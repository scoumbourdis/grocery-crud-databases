<?php
class grocery_crud_model_PDO extends grocery_CRUD_Generic_Model{

    public $NO_CONCAT_DRIVER = array('sqlite');
    public $NO_GROUP_CONCAT = array();

    public function __construct(){
        parent::__construct();
        $this->subdriver = $this->db->subdriver;
    }

    function get_primary_key($table_name = null)
    {
        // let's see what the parent can do
        $primary_key = parent::get_primary_key($table_name);
        if($primary_key !== FALSE){
            return $primary_key;
        }

        // set default value for table_name if not set.
        if(!isset($table_name)){
            $table_name = $this->table_name;
        }

        // postgre need this
        if($this->subdriver=='pgsql'){
            $SQL = "SELECT
                  pg_attribute.attname
                FROM pg_index, pg_class, pg_attribute
                WHERE
                  pg_class.oid = '".$table_name."'::regclass AND
                  indrelid = pg_class.oid AND
                  pg_attribute.attrelid = pg_class.oid AND
                  pg_attribute.attnum = any(pg_index.indkey);";
            $query = $this->db->query($SQL);
            $row = $query->row();
            $primary_key = $row->attname;
        }

        return $primary_key;
    }

    function get_list()
    {
        if($this->table_name === null)
            return false;

        $select = $this->protect_identifiers("{$this->table_name}").".*";

        //set_relation special queries
        if(!empty($this->relation))
        {
            foreach($this->relation as $relation)
            {
                list($field_name , $related_table , $related_field_title) = $relation;
                $unique_join_name = $this->_unique_join_name($field_name);
                $unique_field_name = $this->_unique_field_name($field_name);

                if(strstr($related_field_title,'{'))
                {
                    $related_field_title = str_replace(" ","&nbsp;",$related_field_title);

                    // some DBMS doesn't have "CONCAT" function
                    if(in_array($this->subdriver,$this->NO_CONCAT_DRIVER)){
                        $select .= ", ('".str_replace(array('{','}'),array("' || COALESCE(".$this->protect_identifiers($unique_join_name).".", ", '') || '"),str_replace("'", "\\'", $related_field_title))."') as ".$this->protect_identifiers($unique_field_name);
                    }else{
                        $select .= ", CONCAT('".str_replace(array('{','}'),array("',COALESCE(".$this->protect_identifiers($unique_join_name).".",", ''),'"),str_replace("'","\\'",$related_field_title))."') as ".$this->protect_identifiers($unique_field_name);
                    }
                }
                else
                {
                    $select .= ', ' . $this->protect_identifiers($unique_join_name).'.'. $this->protect_identifiers($related_field_title).' AS '. $this->protect_identifiers($unique_field_name);
                }

                if($this->field_exists($related_field_title))
                    $select .= ', '.$this->protect_identifiers($this->table_name. '.'. $related_field_title).' AS '.$this->protect_identifiers($this->table_name. '.'. $related_field_title);
            }
        }

        //set_relation_n_n special queries. We prefer sub queries from a simple join for the relation_n_n as it is faster and more stable on big tables.
        if(!empty($this->relation_n_n))
        {
            $select = $this->relation_n_n_queries($select);
        }

        $this->db->select($select, false);

        $results = $this->db->get($this->table_name)->result();

        return $results;
    }

    protected function relation_n_n_queries($select)
    {
        $this_table_primary_key = $this->get_primary_key();
        foreach($this->relation_n_n as $relation_n_n)
        {
            list($field_name, $relation_table, $selection_table, $primary_key_alias_to_this_table,
                        $primary_key_alias_to_selection_table, $title_field_selection_table, $priority_field_relation_table) = array_values((array)$relation_n_n);

            $primary_key_selection_table = $this->get_primary_key($selection_table);

            $field = "";
            $use_template = strpos($title_field_selection_table,'{') !== false;
            $field_name_hash = $this->_unique_field_name($title_field_selection_table);
            if($use_template)
            {
                $title_field_selection_table = str_replace(" ", "&nbsp;", $title_field_selection_table);
                // some DBMS doesn't have "CONCAT" function
                if(in_array($this->subdriver,$this->NO_CONCAT_DRIVER)){
                    $field .= "('".str_replace(array('{','}'),array("',COALESCE(",", '') || '"),str_replace("'","\\'",$title_field_selection_table))."')";
                }else{
                    $field .= "CONCAT('".str_replace(array('{','}'),array("',COALESCE(",", ''),'"),str_replace("'","\\'",$title_field_selection_table))."')";
                }
            }
            else
            {
                $field .= $this->protect_identifiers($selection_table.'.'.$title_field_selection_table);
            }

            //Sorry Codeigniter but you cannot help me with the subquery!
            // some DBMS doesn't have "GROUP_CONCAT" function, dunno yet :P
            if(in_array($this->subdriver,$this->NO_GROUP_CONCAT)){
                $select .= ", (SELECT GROUP_CONCAT(DISTINCT ".$this->protect_identifiers($field).") FROM ".$this->protect_identifiers($selection_table)
                    ."LEFT JOIN ".$this->protect_identifiers($relation_table)." ON ".$this->protect_identifiers($relation_table.".".$primary_key_alias_to_selection_table)." = ".$this->protect_identifiers($selection_table.".".$primary_key_selection_table)
                    ."WHERE ".$this->protect_identifiers($relation_table.".".$primary_key_alias_to_this_table)." = ".$this->protect_identifiers($this->table_name.".".$this_table_primary_key)." GROUP BY ".$this->protect_identifiers($relation_table.".".$primary_key_alias_to_this_table).") AS ".$this->protect_identifiers($field_name);
            }else{
                $select .= ", (SELECT GROUP_CONCAT(DISTINCT ".$this->protect_identifiers($field).") FROM ".$this->protect_identifiers($selection_table)
                    ."LEFT JOIN ".$this->protect_identifiers($relation_table)." ON ".$this->protect_identifiers($relation_table.".".$primary_key_alias_to_selection_table)." = ".$this->protect_identifiers($selection_table.".".$primary_key_selection_table)
                    ."WHERE ".$this->protect_identifiers($relation_table.".".$primary_key_alias_to_this_table)." = ".$this->protect_identifiers($this->table_name.".".$this_table_primary_key)." GROUP BY ".$this->protect_identifiers($relation_table.".".$primary_key_alias_to_this_table).") AS ".$this->protect_identifiers($field_name);
            }
        }

        return $select;
    }

}
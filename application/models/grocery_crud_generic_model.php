<?php
class grocery_CRUD_Generic_Model  extends grocery_CRUD_Model  {

    function get_list()
    {
    	if($this->table_name === null)
    		return false;

        $select = $this->db->protect_identifiers("{$this->table_name}").".*";

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
    				$select .= ", CONCAT('".str_replace(array('{','}'),array("',COALESCE({$unique_join_name}.",", ''),'"),str_replace("'","\\'",$related_field_title))."') as $unique_field_name";
				}
    			else
    			{
    				$select .= ', ' . $this->db->protect_identifiers($unique_join_name).'.'. $this->db->protect_identifiers($related_field_title).' AS '. $this->db->protect_identifiers($unique_field_name);
    			}

    			if($this->field_exists($related_field_title))
    				$select .= ', '.$this->db->protect_identifiers($this->table_name).'.'.$this->db->protect_identifiers($related_field_title).' AS '.$this->db->protect_identifiers($this->table_name).'.'.$this->db->protect_identifiers($related_field_title);
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
	    		$field .= "CONCAT('".str_replace(array('{','}'),array("',COALESCE(",", ''),'"),str_replace("'","\\'",$title_field_selection_table))."')";
	    	}
	    	else
	    	{
	    		$field .= "$selection_table.$title_field_selection_table";
	    	}

    		//Sorry Codeigniter but you cannot help me with the subquery!
    		$select .= ", (SELECT GROUP_CONCAT(DISTINCT $field) FROM $selection_table "
    			."LEFT JOIN $relation_table ON $relation_table.$primary_key_alias_to_selection_table = $selection_table.$primary_key_selection_table "
    			."WHERE $relation_table.$primary_key_alias_to_this_table = `{$this->table_name}`.$this_table_primary_key GROUP BY $relation_table.$primary_key_alias_to_this_table) AS $field_name";
    	}

    	return $select;
    }

    function get_total_results()
    {
    	//set_relation_n_n special queries. We prefer sub queries from a simple join for the relation_n_n as it is faster and more stable on big tables.
    	if(!empty($this->relation_n_n))
    	{
    		$select = "{$this->table_name}.*";
    		$select = $this->relation_n_n_queries($select);

    		$this->db->select($select,false);

    		return $this->db->get($this->table_name)->num_rows();
    	}

    	return $this->db->count_all_results($this->table_name);

    }

    function join_relation($field_name , $related_table , $related_field_title)
    {
		$related_primary_key = $this->get_primary_key($related_table);

		if($related_primary_key !== false)
		{
			$unique_name = $this->_unique_join_name($field_name);
			$this->db->join( $related_table.' as '.$unique_name , "$unique_name.$related_primary_key = {$this->table_name}.$field_name",'left');

			$this->relation[$field_name] = array($field_name , $related_table , $related_field_title);

			return true;
		}

    	return false;
    }

    function set_relation_n_n_field($field_info)
    {
		$this->relation_n_n[$field_info->field_name] = $field_info;
    }

    function get_relation_array($field_name , $related_table , $related_field_title, $where_clause, $order_by, $limit = null, $search_like = null)
    {
    	$relation_array = array();
    	$field_name_hash = $this->_unique_field_name($field_name);

    	$related_primary_key = $this->get_primary_key($related_table);

    	$select = "$related_table.$related_primary_key, ";

    	if(strstr($related_field_title,'{'))
    	{
    		$related_field_title = str_replace(" ", "&nbsp;", $related_field_title);
    		$select .= "CONCAT('".str_replace(array('{','}'),array("',COALESCE(",", ''),'"),str_replace("'","\\'",$related_field_title))."') as $field_name_hash";
    	}
    	else
    	{
	    	$select .= "$related_table.$related_field_title as $field_name_hash";
    	}

    	$this->db->select($select,false);
    	if($where_clause !== null)
    		$this->db->where($where_clause);

    	if($where_clause !== null)
    		$this->db->where($where_clause);

    	if($limit !== null)
    		$this->db->limit($limit);

    	if($search_like !== null)
    		$this->db->having("$field_name_hash LIKE '%".$this->db->escape_like_str($search_like)."%'");

    	$order_by !== null
    		? $this->db->order_by($order_by)
    		: $this->db->order_by($field_name_hash);

    	$results = $this->db->get($related_table)->result();

    	foreach($results as $row)
    	{
    		$relation_array[$row->$related_primary_key] = $row->$field_name_hash;
    	}

    	return $relation_array;
    }

    function get_relation_n_n_selection_array($primary_key_value, $field_info)
    {
    	$select = "";
    	$related_field_title = $field_info->title_field_selection_table;
    	$use_template = strpos($related_field_title,'{') !== false;;
    	$field_name_hash = $this->_unique_field_name($related_field_title);
    	if($use_template)
    	{
    		$related_field_title = str_replace(" ", "&nbsp;", $related_field_title);
    		$select .= "CONCAT('".str_replace(array('{','}'),array("',COALESCE(",", ''),'"),str_replace("'","\\'",$related_field_title))."') as $field_name_hash";
    	}
    	else
    	{
    		$select .= "$related_field_title as $field_name_hash";
    	}
    	$this->db->select('*, '.$select,false);

    	$selection_primary_key = $this->get_primary_key($field_info->selection_table);

    	if(empty($field_info->priority_field_relation_table))
    	{
    		if(!$use_template){
    			$this->db->order_by("{$field_info->selection_table}.{$field_info->title_field_selection_table}");
    		}
    	}
    	else
    	{
    		$this->db->order_by("{$field_info->relation_table}.{$field_info->priority_field_relation_table}");
    	}
    	$this->db->where($field_info->primary_key_alias_to_this_table, $primary_key_value);
    	$this->db->join(
    			$field_info->selection_table,
    			"{$field_info->relation_table}.{$field_info->primary_key_alias_to_selection_table} = {$field_info->selection_table}.{$selection_primary_key}"
    		);
    	$results = $this->db->get($field_info->relation_table)->result();

    	$results_array = array();
    	foreach($results as $row)
    	{
    		$results_array[$row->{$field_info->primary_key_alias_to_selection_table}] = $row->{$field_name_hash};
    	}

    	return $results_array;
    }

    function get_relation_n_n_unselected_array($field_info, $selected_values)
    {
    	$use_where_clause = !empty($field_info->where_clause);

    	$select = "";
    	$related_field_title = $field_info->title_field_selection_table;
    	$use_template = strpos($related_field_title,'{') !== false;
    	$field_name_hash = $this->_unique_field_name($related_field_title);

    	if($use_template)
    	{
    		$related_field_title = str_replace(" ", "&nbsp;", $related_field_title);
    		$select .= "CONCAT('".str_replace(array('{','}'),array("',COALESCE(",", ''),'"),str_replace("'","\\'",$related_field_title))."') as $field_name_hash";
    	}
    	else
    	{
    		$select .= "$related_field_title as $field_name_hash";
    	}
    	$this->db->select('*, '.$select,false);

    	if($use_where_clause){
    		$this->db->where($field_info->where_clause);
    	}

    	$selection_primary_key = $this->get_primary_key($field_info->selection_table);
        if(!$use_template)
        	$this->db->order_by("{$field_info->selection_table}.{$field_info->title_field_selection_table}");
        $results = $this->db->get($field_info->selection_table)->result();

        $results_array = array();
        foreach($results as $row)
        {
            if(!isset($selected_values[$row->$selection_primary_key]))
                $results_array[$row->$selection_primary_key] = $row->{$field_name_hash};
        }

        return $results_array;
    }

    function db_relation_n_n_update($field_info, $post_data ,$main_primary_key)
    {
    	$this->db->where($field_info->primary_key_alias_to_this_table, $main_primary_key);
    	if(!empty($post_data))
    		$this->db->where_not_in($field_info->primary_key_alias_to_selection_table , $post_data);
    	$this->db->delete($field_info->relation_table);

    	$counter = 0;
    	if(!empty($post_data))
    	{
    		foreach($post_data as $primary_key_value)
	    	{
				$where_array = array(
	    			$field_info->primary_key_alias_to_this_table => $main_primary_key,
	    			$field_info->primary_key_alias_to_selection_table => $primary_key_value,
	    		);

	    		$this->db->where($where_array);
				$count = $this->db->from($field_info->relation_table)->count_all_results();

				if($count == 0)
				{
					if(!empty($field_info->priority_field_relation_table))
						$where_array[$field_info->priority_field_relation_table] = $counter;

					$this->db->insert($field_info->relation_table, $where_array);

				}elseif($count >= 1 && !empty($field_info->priority_field_relation_table))
				{
					$this->db->update( $field_info->relation_table, array($field_info->priority_field_relation_table => $counter) , $where_array);
				}

				$counter++;
	    	}
    	}
    }

    function db_relation_n_n_delete($field_info, $main_primary_key)
    {
    	$this->db->where($field_info->primary_key_alias_to_this_table, $main_primary_key);
    	$this->db->delete($field_info->relation_table);
    }

    function get_field_types_basic_table()
    {
    	$db_field_types = array();
        echo '<pre>';
        var_dump ($this->db->field_data($this->table_name));
        echo '</pre>';
        foreach($this->db->field_data($this->table_name) as $db_field_type)
    	{
    	    $db_type = $db_field_type->type;
            $length = $db_field_type->max_length;
            $db_field_types[$db_field_type->name]['db_max_length'] = $length;
            $db_field_types[$db_field_type->name]['db_type'] = $db_type;
            $db_field_types[$db_field_type->name]['db_null'] = true;
            $db_field_types[$db_field_type->name]['db_extra'] = '';
    	}

    	$results = $this->db->field_data($this->table_name);
    	foreach($results as $num => $row)
    	{
    		$row = (array)$row;
    		$results[$num] = (object)( array_merge($row, $db_field_types[$row['name']])  );
    	}
    	return $results;
    }

    function get_field_types($table_name)
    {
    	$results = $this->db->field_data($table_name);
    	return $results;
    }

    function db_delete($primary_key_value)
    {
    	$primary_key_field = $this->get_primary_key();

    	if($primary_key_field === false)
    		return false;

        //IN SQLITE this produce error
    	//$this->db->limit(1);
    	$this->db->delete($this->table_name,array( $primary_key_field => $primary_key_value));
    	if( $this->db->affected_rows() != 1)
    		return false;
    	else
    		return true;
    }

    function field_exists($field,$table_name = null)
    {
    	if(empty($table_name))
    	{
    		$table_name = $this->table_name;
    	}

        // sqlite doesn't support this $this->db->field_exists($field,$table_name)
        $field_data_list = $this->db->field_data($table_name);
        foreach($field_data_list as $field_data){
            if($field_data->name == $field) return TRUE;
        }
        return FALSE;
    }

    function get_primary_key($table_name = null)
    {
    	if($table_name == null)
    	{
    		if(isset($this->primary_keys[$this->table_name]))
    		{
    			return $this->primary_keys[$this->table_name];
    		}

	    	if(empty($this->primary_key))
	    	{
		    	$fields = $this->get_field_types_basic_table();

                $primary_key = FALSE;
                foreach($fields as $field)
                {
                    if(isset($field->primary_key) && $field->primary_key == 1)
                    {
                        $primary_key = $field->name;
                        break;
                    }
                }
                // pqsql doesn't provide primary key information. In this case, assume the first field as primary
                if($primary_key === FALSE){
                    $primary_key = $fields[0]->name;
                }

                return $primary_key;
	    	}
	    	else
	    	{
	    		return $this->primary_key;
	    	}
    	}
    	else
    	{
    		if(isset($this->primary_keys[$table_name]))
    		{
    			return $this->primary_keys[$table_name];
    		}

	    	$fields = $this->get_field_types($table_name);

            $primary_key = FALSE;
	    	foreach($fields as $field)
	    	{
	    		if(isset($field->primary_key) && $field->primary_key == 1)
	    		{
	    			$primary_key = $field->name;
                    break;
	    		}
	    	}
            // pqsql doesn't provide primary key information. In this case, assume the first field as primary
            if($primary_key === FALSE){
                $primary_key = $fields[0]->name;
            }

	    	return $primary_key;
    	}

    }

    function escape_str($value)
    {
    	return $this->db->escape_str($value);
    }

}

<?php
class grocery_crud_model_PDO extends grocery_CRUD_Generic_Model{
    public function __construct(){
        parent::__construct();
        $this->subdriver = $this->db->subdriver;
    }
}
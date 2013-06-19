Grocery CRUD Database Models
=============================
This is an extension of grocery CRUD databases to include all the databases that Codeigniter Supports.

How to use
----------
Copy the content of this repository to your CodeIgniter directory.
Modify your `/application/database/database.php`. match it with your database:

Example:
```php
$db['default'] = array(
	'dsn'	=> 'mysql:host=localhost;port=3306;dbname=test_database',
	'hostname' => 'localhost',
	'username' => 'root',
	'password' => 'my_password',
	'database' => 'test_database',
	'dbdriver' => 'pdo',
	'dbprefix' => '',
	'pconnect' => TRUE,
	'db_debug' => TRUE,
	'cache_on' => FALSE,
	'cachedir' => '',
	'char_set' => 'utf8',
	'dbcollat' => 'utf8_general_ci',
	'swap_pre' => '',
	'autoinit' => TRUE,
	'encrypt' => FALSE,
	'compress' => FALSE,
	'stricton' => FALSE,
	'failover' => array()
);
```
If you want to use sqlite, change your dsn into this `'sqlite:'.FCPATH.'example_database/sqlite_example_database.sqlite'`

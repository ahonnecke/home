#!/usr/bin/php
<?php

$usage = "Usage: \n    makeportal.php -t=table_name \n\n";

$options = getopt("v:t::");

if(empty($options)) die($usage);

/* echo "Gimmie comma delimited fields: "; */
/* $handle = fopen("php://stdin","r"); */
/* $fields = fgets($handle); */
/* if(! trim($fields)){ */
/*     echo "ABORTING!\n"; */
/*     exit; */
/* } */
$table_name = $options['t'];
$className = preg_replace('/(?:^|_)(.?)/e',"strtoupper('$1')",$table_name); 

echo "\n";
echo "Table: $table_name\n";
echo "Class: $className\n";

//use connection, read from table and get create info

$fieldArray = array('one','two');
echo '* ';
echo implode("\n * ", $fieldArray);
echo "\n";

$base = '<?php';
$base .= "\n/**\n";
$base .= " * This is the model class for table '$table_name'.\n";
$base .= " *\n";
$base .= " * The followings are the available columns in table '$table_name':\n";
foreach($fieldArray as $col) {
    $base .= " * @property string \$$col\n";
}
$base .= "\n";
$base .= " */\n";
$base .= "class Base$className extends CSUGActiveRecord {\n";
$base .= "\n";
foreach($fieldArray as $col) {
    $base .= "    public \$$col;\n";
}
//$base .= "    public function __toString(){\n";
//$base .= "    }\n";

$base .= "    public function search() {\n";
$base .= "        // @todo Please modify the following code to remove attributes that should not be searched.\n";
$base .= "\n";
$base .= "        \$criteria = new CDbCriteria;\n";
$base .= "\n";
$base .= "        \$sort = new CSort();\n";

$base .= "        \$sort->attributes = array(\n";
/* $base .= "            '$pk' => array(\n"; */
/* $base .= "                'asc' => '$pk asc',\n"; */
/* $base .= "                'desc' => '$pk desc',\n"; */
/* $base .= "                'default' => 'asc'\n"; */
/* $base .= "            ),\n"; */

foreach($fieldArray as $col) {
    $base .= "            '$col' => array(\n";
    $base .= "                'asc' => '$col asc',\n";
    $base .= "                'desc' => '$col desc',\n";
    $base .= "                'default' => 'asc'\n";
    $base .= "            ),\n";
}
$base .= "        );\n";

//$base .= "        \$sort->defaultOrder = array('$pk' => CSort::SORT_ASC);\n";
$base .= "\n";
$base .= "\n";
$base .= "        return new CActiveDataProvider(\$this, array(\n";
$base .= "            'criteria' => \$criteria,\n";
$base .= "            'sort' => \$sort,\n";
$base .= "            'pagination' => array(\n";
$base .= "                'pageSize' => ".'Yii::app()->params[\'db_default_query_limit\']'.",\n";
$base .= "            ),\n";
$base .= "        ));\n";
$base .= "\n";
$base .= "    }\n";

$base .= "\n";
$base .= "	/**\n";
$base .= "	 * Returns the static model of the specified AR class.\n";
$base .= "	 * Please note that you should have this exact method in all your CActiveRecord descendants!\n";
$base .= "	 * @param string $className active record class name.\n";
$base .= "	 * @return Pages the static model class\n";
$base .= "	 */\n";
$base .= "	public static function model(\$className=__CLASS__)\n";
$base .= "	{\n";
$base .= "		return parent::model(\$className);\n";
$base .= "	}\n";
$base .= "\n";

$base .= "}\n";

$base .= "\n";

$fileName = $className.'.php';
$baseName = 'Base'.$fileName;

//rewrite base no matter what
file_put_contents($baseName, $base);

$empty = '<?php';
$empty .= "\n";
$empty .= "\n";
$empty .= "class $className extends Base$className {\n";
$empty .= "\n";
$empty .= "}\n";
$empty .= "\n";


//only make if it's not there
if(!file_exists($fileName)) file_put_contents($fileName, $empty);

echo exec("php -l $baseName")."\n";
echo exec("php -l $fileName")."\n";

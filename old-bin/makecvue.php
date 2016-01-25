#!/usr/bin/php
<?php

$usage = "Usage: \n    makecvue.php -v Web_StaffInfo_vw -i SyStaffID -c EnrollID,SyStudentID \n\n";

$options = getopt("v:i:c:f::");

if(empty($options)) die($usage);

/* echo "Gimmie comma delimited fields: "; */
/* $handle = fopen("php://stdin","r"); */
/* $fields = fgets($handle); */
/* if(! trim($fields)){ */
/*     echo "ABORTING!\n"; */
/*     exit; */
/* } */
$view = $options['v'];
$identity = $options['i'];
$colList = $options['c'];
//$filename = $options['f'];
$className = 'CVue'.str_replace(array('_vw','Web_'),'',$view);

echo "\n";
echo "View: $view\n";
echo "Identity: $identity\n";
//echo "Filename: $filename\n";
echo "Class: $className\n";
echo "Columns:\n ";

$fieldArray = explode(',', str_replace(' ', '', $colList));
echo '* ';
echo implode("\n * ", $fieldArray);
echo "\n";

if($key = array_search($identity, $fieldArray)) {
    unset($fieldArray[$key]);
}

$command = "makecvue.php"
    . " -v $view "
    . " -i $identity "
    . " -c $colList";

$base = '<?php';
$base .= "\n/**\n";
$base .= " * This is the model class for view '$view'.\n";
$base .= " * It was automatically generated with the following command\n";
$base .= " * $command\n";
$base .= " *\n";
$base .= " * The followings are the available columns in view '$view':\n";
$base .= " * @property integer \$$identity\n";
foreach($fieldArray as $col) {
    $base .= " * @property string \$$col\n";
}
$base .= "\n";
$base .= " */\n";
$base .= "class Base$className extends CVueActiveRecord {\n";
$base .= "\n";
$base .= "    public \$$identity;\n";
foreach($fieldArray as $col) {
    $base .= "    public \$$col;\n";
}
$base .= "\n";
$base .= "    const VIEW = '$view';\n";
$base .= "    const IDENTITY = '$identity';\n";
$base .= "    const COLUMNS = '$identity,";
$base .= implode(',', $fieldArray)."';\n";
$base .= "    const REQUIRED = '$identity';\n";
$base .= "\n";
$base .= "    /**\n";
$base .= "     * @return array customized attribute labels (name=>label)\n";
$base .= "     */\n";
$base .= "    public function attributeLabels() {\n";
$base .= "        return array(\n";
$base .= "            '$identity' => '".str_replace('ID', ' ID', $identity)."',\n";
foreach($fieldArray as $col) {
    $base .= "            '$col' => '".str_replace('ID', ' ID', $col)."',\n";
}
$base .= "        );\n";
$base .= "    }\n";
$base .= "\n";
$base .= "    /**\n";
$base .= "     * Retrieves a list of models based on the current search/filter conditions.\n";
$base .= "     *\n";
$base .= "     * Typical usecase:\n";
$base .= "     * - Initialize the model fields with values from filter form.\n";
$base .= "     * - Execute this method to get CActiveDataProvider instance which will filter\n";
$base .= "     * models according to data in model fields.\n";
$base .= "     * - Pass data provider to CGridView, CListView or any similar widget.\n";
$base .= "     *\n";
$base .= "     * @return CActiveDataProvider the data provider that can return the models\n";
$base .= "     * based on the search/filter conditions.\n";
$base .= "     */\n";

$base .= "    public function __toString(){\n";
$base .= "        echo \$this->$identity;\n";
$base .= "    }\n";

$base .= "    public function search() {\n";
$base .= "        // @todo Please modify the following code to remove attributes that should not be searched.\n";
$base .= "\n";
$base .= "        \$criteria = new CDbCriteria;\n";
$base .= "\n";
$base .= "        \$criteria->compare('$identity', \$this->$identity);\n";
foreach($fieldArray as $col) {
    $base .= "        \$criteria->compare('$col', \$this->$col, true);\n";
}
$base .= "\n";
$base .= "        \$sort = new CSort();\n";

$base .= "        \$sort->attributes = array(\n";
$base .= "            '$identity' => array(\n";
$base .= "                'asc' => '$identity asc',\n";
$base .= "                'desc' => '$identity desc',\n";
$base .= "                'default' => 'asc'\n";
$base .= "            ),\n";

foreach($fieldArray as $col) {
    $base .= "            '$col' => array(\n";
    $base .= "                'asc' => '$col asc',\n";
    $base .= "                'desc' => '$col desc',\n";
    $base .= "                'default' => 'asc'\n";
    $base .= "            ),\n";
}
$base .= "        );\n";

$base .= "        \$sort->defaultOrder = array('$identity' => CSort::SORT_ASC);\n";
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

$base .= "    public function findByPk(\$pk, \$condition = '', \$params = Array()){\n";
$base .= "        return self::model()->findByAttributes(array(self::IDENTITY=>\$pk));\n";
$base .= "    }\n";

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

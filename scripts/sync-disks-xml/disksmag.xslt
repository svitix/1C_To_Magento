<xsl:stylesheet version = '1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<!-- Выводим информацию в текстовом виде -->
<xsl:output method="text" encoding="utf-8" indent="no"/>
	
	<!-- Удаляем лишнее: пробел (#x20), возврат каретки (#xD), перевод строки (#xA), знак табуляции (#x9) -->
	<xsl:strip-space elements="*"/>
	
	<!--Разделитель для колонок -->
	<xsl:variable name="razdel">#</xsl:variable>
	
	<!--Путь к файлы с ценами -->
	<xsl:variable name="file_offers" select="document('/smb/ShareShop/disk/1cbitrix/offers.xml')"></xsl:variable>
	<!-- document('/var/smb/i-shop/tyres/1cbitrix/offers.xml') -->
	
	<!-- тип интернет цены -->
	<xsl:variable name="price1" select="$file_offers/КоммерческаяИнформация/ПакетПредложений/ТипыЦен/ТипЦены[Наименование='Интернет-магазин']/Ид"></xsl:variable>

	<!-- тип розничной цены -->
	<xsl:variable name="price3" select="$file_offers/КоммерческаяИнформация/ПакетПредложений/ТипыЦен/ТипЦены[Наименование='Розничная']/Ид"></xsl:variable>
	
	<!-- тип специальной цены -->
	<xsl:variable name="price2" select="$file_offers/КоммерческаяИнформация/ПакетПредложений/ТипыЦен/ТипЦены[Наименование='_Ярмарка']/Ид"></xsl:variable>

	<!-- *Ширина обода -->
	<xsl:variable name="disk_width" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='2_Ширина_ДИСКА']/Ид"></xsl:variable>
	
	<!-- *Диаметр обода -->
	<xsl:variable name="disk_diameter" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='21_Диаметр_ДИСКА']/Ид"></xsl:variable>
	
	<!-- *Количество отверстий -->
	<xsl:variable name="disk_bolthole" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='1_1_Количество отверстий PCD1']/Ид"></xsl:variable>

	<!-- *PCD -->
	<xsl:variable name="disk_pcd" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='1_2_PCD1']/Ид"></xsl:variable>

	<!-- Центральное отверстие -->
	<xsl:variable name="disk_centerhole" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='4_ДиаметрЦентральногоОтверстия']/Ид"></xsl:variable>

	<!-- Вылет -->
	<xsl:variable name="disk_et" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='3_Вылет_ДИСКА']/Ид"></xsl:variable>

	<!-- атрибут фирма производитель -->
	<xsl:variable name="disk_manufacturer" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='6_Фирма-производитель']/Ид"></xsl:variable>

	<!--              -->

	<!-- атрибут 9_Цвет (окраска) -->
	<xsl:variable name="disk_color" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='9_Цвет (окраска)']/Ид"></xsl:variable>

	<!-- атрибут 1_0_Технология изготовления -->
	<xsl:variable name="disk_produce" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='1_0_Технология изготовления']/Ид"></xsl:variable>

	<!-- атрибут 1_0_1 Материал -->
	<xsl:variable name="disk_material" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='1_0_1 Материал']/Ид"></xsl:variable>

	<!-- атрибут 5_Дизайн диска -->
	<xsl:variable name="disk_design" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='5_Дизайн диска']/Ид"></xsl:variable>
	
	
	
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
  
  <xsl:template match="Классификатор">

 <xsl:text>sku,_attribute_set,_type,_category,_root_category,_product_websites,name,description,disk_diameter,disk_manufacturer,disk_width,disk_bolthole,disk_centerhole,disk_et,disk_pcd,price,qty,short_description,weight,status,visibility,tax_class_id
</xsl:text>  
 </xsl:template>

  <xsl:template match="Товары">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="Владелец"></xsl:template>
  <xsl:template match="Каталог/Ид"></xsl:template>
  <xsl:template match="Каталог/Наименование"></xsl:template>
  <xsl:template match="Каталог/ИдКлассификатора"></xsl:template>
  
  <xsl:template match="Товар">
	
	<!-- поле 01 sku        -->	
	<xsl:value-of select="Ид"/>
	<xsl:value-of select="$razdel" />
	
	<!-- Запоминаем ИД для дальнейшей работы -->
	<xsl:variable name="id" select="Ид"></xsl:variable>	
	
	<!-- поле 08 description   -->     
	<xsl:value-of select="ЗначенияРеквизитов/ЗначениеРеквизита[Наименование='Полное наименование']/Значение"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:variable name="disk_width1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$disk_width]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$disk_width1]/Значение"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:variable name="disk_diameter1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$disk_diameter]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$disk_diameter1]/Значение"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:variable name="disk_bolthole1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$disk_bolthole]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$disk_bolthole1]/Значение"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:variable name="disk_pcd1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$disk_pcd]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$disk_pcd1]/Значение"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:variable name="disk_centerhole1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$disk_centerhole]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$disk_centerhole1]/Значение"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:variable name="disk_et1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$disk_et]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$disk_et1]/Значение"/>
	<xsl:value-of select="$razdel" />	

	<xsl:variable name="disk_manufacturer1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$disk_manufacturer]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$disk_manufacturer1]/Значение"/>
	<xsl:value-of select="$razdel" />	
	
	<xsl:value-of select="$file_offers/КоммерческаяИнформация/ПакетПредложений/Предложения/Предложение[Ид=$id]/Цены/Цена[ИдТипаЦены=$price1]/ЦенаЗаЕдиницу"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:value-of select="$file_offers/КоммерческаяИнформация/ПакетПредложений/Предложения/Предложение[Ид=$id]/Количество"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:value-of select="ЗначениеРеквизита[Наименование='ОписаниеВФорматеHTML']/Значение"/>
	<xsl:value-of select="$razdel" />	
	
	<xsl:variable name="disk_color1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$disk_color]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$disk_color1]/Значение"/>
	<xsl:value-of select="$razdel" />	
	
	<xsl:variable name="disk_produce1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$disk_produce]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$disk_produce1]/Значение"/>
	<xsl:value-of select="$razdel" />	
	
	<xsl:variable name="disk_material1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$disk_material]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$disk_material1]/Значение"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:variable name="disk_design1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$disk_design]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$disk_design1]/Значение"/>
	<xsl:value-of select="$razdel" />

	<xsl:value-of select="Картинка"/>
	<xsl:value-of select="$razdel" />

<xsl:text>
</xsl:text>
    
  </xsl:template>

	 <xsl:template match="Классификатор">
	 </xsl:template>


  </xsl:stylesheet>
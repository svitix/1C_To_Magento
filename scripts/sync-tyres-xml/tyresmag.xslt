<xsl:stylesheet version = '1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<!-- Выводим информацию в текстовом виде -->
<xsl:output method="text" encoding="utf-8" indent="no"/>
	
	<!-- Удаляем лишнее: пробел (#x20), возврат каретки (#xD), перевод строки (#xA), знак табуляции (#x9) -->
	<xsl:strip-space elements="*"/>
	
	<!--Разделитель для колонок -->
	<xsl:variable name="razdel">#</xsl:variable>
	
	<!--Путь к файлы с ценами -->
	<xsl:variable name="file_offers" select="document('/smb/ShareShop/tyres/1cbitrix/offers.xml')"></xsl:variable>
	<!-- document('/var/smb/i-shop/tyres/1cbitrix/offers.xml') -->
	
	<!-- тип интернет цены -->
	<xsl:variable name="price1" select="$file_offers/КоммерческаяИнформация/ПакетПредложений/ТипыЦен/ТипЦены[Наименование='Интернет-магазин']/Ид"></xsl:variable>

	<!-- тип розничной цены -->
	<xsl:variable name="price3" select="$file_offers/КоммерческаяИнформация/ПакетПредложений/ТипыЦен/ТипЦены[Наименование='Розничная']/Ид"></xsl:variable>
	
	<!-- тип специальной цены -->
	<xsl:variable name="price2" select="$file_offers/КоммерческаяИнформация/ПакетПредложений/ТипыЦен/ТипЦены[Наименование='_Ярмарка']/Ид"></xsl:variable>

	<!-- атрибут размерность шин -->
	<xsl:variable name="tyres_width" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='1_Размерность ШИН']/Ид"></xsl:variable>

	<!-- атрибут фирма производитель -->
	<xsl:variable name="producer" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='6_Фирма-производитель']/Ид"></xsl:variable>

	<!-- атрибут сезонность  проверка на лето-->
	<xsl:variable name="tyres_season1" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='61_Сезонность_Лето']/Ид"></xsl:variable>

	<!-- атрибут сезонность проверка на зиму-->
	<xsl:variable name="tyres_season2" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='62_Сезонность_Зимняя']/Ид"></xsl:variable>

	<!-- атрибут Индексы НагрузкаСкорость -->
	<xsl:variable name="tyres_index" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='Индексы НагрузкаСкорость']/Ид"></xsl:variable>

	
	<!-- атрибут 61_Рисунок протектора_не шипы -->
	<xsl:variable name="tyres_protektor1" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='61_Рисунок протектора_не шипы']/Ид"></xsl:variable>
	<!-- атрибут 3_Рисунок протектора_ШИПЫ -->
	<xsl:variable name="tyres_protektor2" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='3_Рисунок протектора_ШИПЫ']/Ид"></xsl:variable>
	<!-- атрибут 4_Рисунок протектора_лето -->
	<xsl:variable name="tyres_protektor3" select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство[Наименование='4_Рисунок протектора_лето']/Ид"></xsl:variable>

	
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
	
	<xsl:variable name="tyres_width1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$tyres_width]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$tyres_width1]/Значение"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:variable name="producer1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$producer]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$producer1]/Значение"/>
	<xsl:value-of select="$razdel" />

	<xsl:variable name="tyres_season12" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$tyres_season1]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$tyres_season12]/Значение"/>
	
    <xsl:variable name="tyres_season22" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$tyres_season2]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$tyres_season22]/Значение"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:value-of select="$file_offers/КоммерческаяИнформация/ПакетПредложений/Предложения/Предложение[Ид=$id]/Цены/Цена[ИдТипаЦены=$price1]/ЦенаЗаЕдиницу"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:value-of select="$file_offers/КоммерческаяИнформация/ПакетПредложений/Предложения/Предложение[Ид=$id]/Количество"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:value-of select="Картинка"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:variable name="tyres_protektor11" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$tyres_protektor1]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$tyres_protektor11]/Значение"/>
	<xsl:variable name="tyres_protektor22" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$tyres_protektor2]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$tyres_protektor22]/Значение"/>
	<xsl:variable name="tyres_protektor33" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$tyres_protektor3]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$tyres_protektor33]/Значение"/>
	<xsl:value-of select="$razdel" />
	
	<xsl:value-of select="normalize-space(ЗначениеРеквизита[Наименование='ОписаниеВФорматеHTML']/Значение)"/>
	
	<xsl:value-of select="$razdel" />
	
	<xsl:variable name="tyres_index1" select="ЗначенияСвойств/ЗначенияСвойства[Ид=$tyres_index]/Значение"></xsl:variable>
	<xsl:value-of select="/КоммерческаяИнформация/Классификатор/Свойства/Свойство/ВариантыЗначений/Справочник[ИдЗначения=$tyres_index1]/Значение"/>
	<xsl:value-of select="$razdel" />

<xsl:text>
</xsl:text>
    
  </xsl:template>

	 <xsl:template match="Классификатор">
	 </xsl:template>


  </xsl:stylesheet>
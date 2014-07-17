BEGIN{
    FS="#"
    print "product_name#name#sku#qty#short_description#description#disk_width#disk_diameter#disk_bolthole#disk_pcd#price#store#websites#attribute_set#type#category_ids#status#visibility#tax_class_id#product_type_id#is_in_stock#weight#disk_centerhole#disk_et#disk_manufacturer#disk_color#disk_produce#disk_material#disk_design";
}

{
    rzdl="#"
#qty -- 11
    descshort = "";
    desclong  = $12;
#	image= "\" $17;
#    image = "/" $17;
    print $2 rzdl $2 rzdl $1 rzdl $11 rzdl descshort rzdl desclong rzdl $3 rzdl $4 rzdl $5 rzdl $6 rzdl $10 "#admin#base#disks#simple#4#Включено#Каталог, поиск#Отсутствует#simple#1#1.0"  rzdl $7 rzdl $8 rzdl $9 rzdl $13 rzdl $14 rzdl $15 rzdl $16;
}
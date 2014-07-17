BEGIN{
    FS="#"
    print "product_name#name#sku#qty#short_description#description#tyres_width#tyres_height#tyres_diameter#tyres_season#tyres_ship#price#tyres_manufacturer#store#websites#attribute_set#type#category_ids#status#visibility#tax_class_id#product_type_id#is_in_stock#weight#tyres_protektor#tyres_index";
}

{
    rzdl="#"
    sizeof=$3;
    test=""; 
    nuka=gsub("/"," мм#",sizeof);
    
    if(!nuka) test=" мм#";

    if($5 ~ "Летняя") season="Летние";
    if(($5 ~ "Зимняя_шипованная") || ($5 ~ "Зимняя_Нешипованная")) 
	season="Зимние";

    if($5 ~ "Зимняя_шипованная") {
	ship="да";    
    } else {
	ship="нет";
    }

    match($2, /R[0-9][0-9]/) ;
    razmer=substr($2,RSTART+1,RLENGTH-1)  " \"";

#    print  $1 rzdl $2 rzdl sizeof test "," $4 rzdl $6 rzdl $7 rzdl season rzdl razmer rzdl ship
# $1 sku
# $2 name
# $6 price
# $7 qty
    descshort = "";
    desclong  = "";
#	corect below line
    if ($8 == "") {
	image="";
    } else {
	image = "/" $8;
    }
#    image ="";
    print $2 rzdl $2 rzdl $1 rzdl $7 rzdl descshort rzdl $10 rzdl sizeof test rzdl razmer rzdl season rzdl ship rzdl $6 rzdl $4 "#admin#base#tyres#simple#3#Включено#Каталог, поиск#Отсутствует#simple#1#1.0" rzdl $9 rzdl $11;
}
#!/bin/bash
clear
#verificamos si existe el fichero logs.txt
verif_logs=$(ls logs.txt 2>/nev/null)
if [ -z "$verif_logs" ]; then
touch logs.txt
#si no existe lo crea > logs.txt
fi
menu(){
echo "MENU DE USUARIOS"
echo "1- agregar usuario"
echo "2- borrar usuario"
echo "3- modificar usuario"
echo "4- lista usuarios"
echo "5- crear grupo"
echo "6- listar grupo"
echo "7- salir"
read opc
case $opc in
1) agregarUser;;
2) borrarUser;;
3) modificarUser;;
4) listaUser;;
5) creagrupo;;
6) listagrupo;;
7) salir;;
esac
}

agregarUser(){
clear
 read -p "ingrese nombre" us
 read -p "ingrese grupo al que pertenece" gr
read -p "ingrese contraseña" ps
useradd -d/home/$us-s/bin/bash -g $gr -m $ps
echo "usuario creado correctamente"
sleep 2
echo "creando password para usuario"
echo $us $ps | chpasswd
sleep 2
clear
echo "usuario creado con exito"
sleep 3
menu
}


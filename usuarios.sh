#!/bin/bash
menu(){
clear
echo "Menú Gestión de Usuarios: "
echo ""
echo "1- Agregar Usuario"
echo "2- Borrar Usuario"
echo "3- Modificar Usuario"
echo "4- Lista de Usuarios"
echo "5- crear grupo"
echo "6- listar grupo"
echo "7- eliminar grupo"
echo "8- Salir"
echo "*) opcion incorrecta"
read -p "Seleccione opción: " opc
case $opc in

1) agregarUser;;
2) borrarUser;;
3) modUser;;
4) ListaUsuarios;;
5) crearGrupo;;
6) listarGrupo;;
7) borrarGrupo;;
8) salir;;
esac
}

agregarUser(){

read -p "Ingrese Nuevo Usuario:" user
sudo useradd -m -d "/home/$user" -s /bin/bash "$user"
if [ $? -eq 0 ]; then
sudo passwd "$user"
echo "$user creado correctamente"
else
echo "error al crear usuario"
fi
sleep 4
menu
}
borrarUser(){
echo "introduce el nombre de usuario que deseas eliminar"
read -p user
sudo userdel -r $user
echo "usuario $user se elimino correctamente"
sleep 4
menu
}

modUser(){
echo "MODIFICAR USUARIO"
echo "1) cambiar nombre"
echo "2) modificar contraseña"
echo "3) cambiar grupo"

read -p "opcion:" op

case $op in
1) cambiarnombre ;;
2) modPasswd ;;
3) cambiagrupo ;;
esac
}

cambiarnombre(){
read -p "ingrese usuario a modificar:" usuario
if id "$usuario" &>/dev/null; then
read -p "ingrese nuevo nombre:" nombre
sudo usermod -l "$nombre" "$usuario"
echo "usuario modificado correctamente"
else
echo "el usuario no existe"
fi
sleep 4
menu
}
modPasswd(){
read -p "ingrese el nombre del usuario:" usuario
if id "$usuario" &>/dev/null; then
sudo passwd "$usuario"
echo "se ha modificado la contraseña"
else
echo "usuario no encontrado"
fi
sleep 4
menu
}

cambiagrupo(){
read -p "usuario:" usuario
read -p "grupo:" grupo
 if id "$usuario" &>/dev/null; then
        sudo usermod -aG "$grupo" "$usuario"
        echo "Grupo modificado correctamente"
    else
        echo "Usuario no encontrado"
    fi
sleep 4
menu
}
ListaUsuarios(){
clear
echo "usuarios:"
echo ""
less /etc/passwd | cut -d ":" -f1
echo ""
read -p "presione enter para volver atras" b
sleep 2
menu
}
crearGrupo(){
read -p "ingrese nombre de grupo a crear:" grupo
sudo groupadd $grupo
sleep 2
menu
}
listarGrupo(){
clear
echo "aqui estan los grupos"
cut -d ":" -f1 /etc/group
sleep 3
menu
}
borrarGrupo(){
echo "ingrese nombre de grupo a eliminar"
read gr
sudo groupdel $gr
echo "grupo eliminado correctamente"
sleep 4
menu
}
salir(){
echo "saliendo...."
sleep 3
exit
}
menu

#!/bin/bash
clave= "1234"
LOG="Log_usuarios.enc"
cifrar(){
echo "$1" | openssl enc -aes-256-cbc -a -salt -pbkdf2 -pass pass:$clave >> "$LOG"
}
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
cifrar "usuario creado: $user"
else
echo "error al crear usuario"
fi
sleep 4
menu
}
borrarUser(){
echo "introduce el nombre de usuario que deseas eliminar"
read -p "usuario: " user
sudo userdel -r $user
if [ $? -eq 0 ]; then
echo "usuario $user se elimino correctamente"
cifrar "usuario eliminado: $user"
else
echo "error el usuario no existe"
fi
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
cifrar "contraseña para: $usuario"
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
awk -F: '$3 >= 1000 {print $1}' /etc/passwd
echo ""
read -p "presione enter para volver atras" b
sleep 2
menu
}
crearGrupo(){
read -p "ingrese nombre de grupo a crear:" grupo
grupo=$(echo "$grupo" | xargs)

echo "DEBUG creando: '$grupo'"

sudo groupadd $grupo
code=$?

echo "DEBUG exit code: $code"
if [ $code -eq 0 ]; then
echo "$grupo" >> grupos_creados.txt
echo "grupo creado correctamente"
else
echo "error al crear grupo"
fi
sleep 2
menu
}
listarGrupo(){
clear
echo "aqui estan los grupos"
cat grupos_creados.txt
read -p "precione enter para volver" b
sleep 3
menu
}
borrarGrupo(){
echo "ingrese nombre de grupo a eliminar"
read gr
gr=$(echo "$gr" | xargs)
echo "DEBUG: '$gr'"
sudo groupdel "$gr"

if [ $? -eq 0 ]; then
sed -i "/^$gr$/d" grupos_creados.txt
echo "grupo eliminado correctamente"
else
echo "el grupo no existe"
fi
sleep 4
menu
}
salir(){
echo "saliendo...."
sleep 3
exit
}
menu

#!/bin/bash

#Variables globales.
url_vulnhub="https://docs.google.com/spreadsheets/d/1dzvaGlT_0xnT-PGO27Z_4prHgA8PHIpErmoWdlUrSoA/export?format=csv&id=1dzvaGlT_0xnT-PGO27Z_4prHgA8PHIpErmoWdlUrSoA&gid=810933541"
url_htb="https://docs.google.com/spreadsheets/d/1dzvaGlT_0xnT-PGO27Z_4prHgA8PHIpErmoWdlUrSoA/export?format=csv&id=1dzvaGlT_0xnT-PGO27Z_4prHgA8PHIpErmoWdlUrSoA&gid=0";
declare -i counter=0;

#Colours
greenColour="\e[0;32m\033[1m";
endColour="\033[0m\e[0m";
redColour="\e[0;31m\033[1m";
blueColour="\e[0;34m\033[1m";
yellowColour="\e[0;33m\033[1m";
purpleColour="\e[0;35m\033[1m";
turquoiseColour="\e[0;36m\033[1m";
grayColour="\e[0;37m\033[1m";



trap ctrl_c INT;

function banner()
{
  echo -e "\n ${purpleColour}\n███████╗███████╗ █████╗ ██████╗  ██████╗██╗  ██╗                
██╔════╝██╔════╝██╔══██╗██╔══██╗██╔════╝██║  ██║                
███████╗█████╗  ███████║██████╔╝██║     ███████║                
╚════██║██╔══╝  ██╔══██║██╔══██╗██║     ██╔══██║                
███████║███████╗██║  ██║██║  ██║╚██████╗██║  ██║                
╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝                
                                                                
███╗   ███╗ █████╗  ██████╗██╗  ██╗██╗███╗   ██╗███████╗███████╗
████╗ ████║██╔══██╗██╔════╝██║  ██║██║████╗  ██║██╔════╝██╔════╝
██╔████╔██║███████║██║     ███████║██║██╔██╗ ██║█████╗  ███████╗
██║╚██╔╝██║██╔══██║██║     ██╔══██║██║██║╚██╗██║██╔══╝  ╚════██║
██║ ╚═╝ ██║██║  ██║╚██████╗██║  ██║██║██║ ╚████║███████╗███████║
╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝
                                                                 ${endColour}";
  echo -e "${yellowColour} By: c0l1nr00t \n thanks: s4vitar ${endColour}";
}

function adios_cursor()
{
  tput civis;
}

function hola_cursor()
{
  tput cnorm;
}

function ctrl_c()
{
  echo -e "\n ${yellowColour}[!]${endColour} ${redColour}Saliendo... ${endColour} \n";
  exit_tool 1;
}

function exit_tool()
{
  code=$1;
  hola_cursor;
  exit $code;
}


# Funcionalidades del sistema
# catch error default case
function catch_default()
{
  echo -e "\n ${redColour}Falta de parametros para la busqueda ${endColour} \n";
  helpPanel;
  exit_tool 1;
}

# Panel de ayuda
function helpPanel()
{
  echo -e "\n ${yellowColour}[?]${endColour}${grayColour} PANEL DE AYUDA${endColour}${grayColour}:${endColour}\n";
  echo -e "\n\t${yellowColour}-h: ${endColour}${grayColour}Muestra este panel de ayuda.${endColour}\n";
  echo -e "\n\t${yellowColour}-u: ${endColour}${grayColour}Update máquinas.${endColour}\n";
  echo -e "\n\t${yellowColour}-m: ${endColour}${grayColour}Buscar por nombre de la maquina.${endColour}\n";
}

# Funcion para hacer el download de los archivos y verificar cambios
function updateFiles()
{
  #revisando si existe las maquinas de HTB
  if [ ! -f machines_htb ]; then
    echo -e "\n ${yellowColour}[+]${endColour}${grayColour}Descargando máquinas de HTB...${endColour}";
    wget ${url_htb} -q -O machines_htb; 
    wget ${url_vulnhub} -q -O machines_vulnhub;
  else
    echo -e "\n ${yellowColour}[+] Comprobando actualizaciones de HTB ...${endColour}";
  fi
}

# Logica del programa
adios_cursor;
banner;

# Options
while getopts "m:hu" arg; do
  case $arg in 
    m)nameMachine=$OPTARG;let counter=1; ;;
    u)let counter=2; ;;
    h)let counter=3; ;;
  esac done;

#Valuacion de opciones
case $counter in
  1) searchByName;;
  2) updateFiles;;
  3) helpPanel;;
  *) catch_default;;
esac;


# Terminando ejecucion.
exit_tool 1;

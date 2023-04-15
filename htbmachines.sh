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

function imprime_nombre_por_dif()
{
  dificultad="$1";
  imprime="$2"
  info="$3";

  case "${dificultad}" in 
    F*) echo -e "\n${yellowColour}[*] ${endColour}${blueColour}${info}:${endColour}${greenColour} ${imprime}${endColour}"; ;;
    M*) echo -e "\n${yellowColour}[*] ${endColour}${blueColour}${info}:${endColour}${yellowColour} ${imprime}${endColour}"; ;;
    D*) echo -e "\n${yellowColour}[*] ${endColour}${blueColour}${info}:${endColour}${redColour} ${imprime}${endColour}"; ;;
    I*) echo -e "\n${yellowColour}[*] ${endColour}${blueColour}${info}:${endColour}${purpleColour} ${imprime}${endColour}"; ;;
    *)  echo -e "\n${redColour}Error al imprimir${endColour} |"; ;;
  esac
}

# Fucnion para imprimier un arreglo con informaicon de la maquina encontrada
function imprime_maquina()
{
  information=("$@");
  nombre_maquina="${information[0]}";
  IP=$(echo "${information[1]}" | tr -d '\n');
  OS=$(echo "${information[2]}" | tr -d '\n');
  skills=$(echo -e "${information[4]}" | sed 's/\n/, /g' | column);
  cert=$(echo -e "${information[5]}" | sed 's/\n/, /g' | column);
  url=$(echo "${information[6]}" | tr -d '\n');

  for index in "${!information[@]}"
  do
    case ${index} in
      0)imprime_nombre_por_dif ${information[3]} ${nombre_maquina} "Nombre"; ;;
      1)echo -e "\n${yellowColour}[*] ${endColour}${blueColour}IP:${endColour} ${purpleColour}$IP${endColour}"; ;;
      2)echo -e "\n${yellowColour}[*] ${endColour}${blueColour}SO:${endColour} ${purpleColour}$OS${endColour}"; ;;
      3)imprime_nombre_por_dif ${information[3]} ${information[3]} "Dificultad"; ;;
      4)echo -e "\n${yellowColour}[*] ${endColour}${blueColour}Skills:${endColour}\n\n${grayColour}$skills${endColour}"; ;;
      5)echo -e "\n${yellowColour}[*] ${endColour}${blueColour}Certificaciones:$endColour\n\n${grayColour}$cert${endColour}"; ;;
      6)echo -e "\n${yellowColour}[*] ${endColour}${blueColour}URL:${endColour} ${greenColour}$url${purpleColour}"; ;;
    esac
  done;
}
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
  #revisando maquinas de vulnhub
  if [ ! -f machines_vulnhub ]; then
    echo -e "\n ${yellowColour}[+]${endColour}${grayColour} Descargando máquinas de Vulnhub...${endColour}";
    wget ${url_vulnhub} -q -O machines_vulnhub;
  else
    echo -e "\n ${yellowColour}[+] Comprobando actualizaciones de Vulnhub ...${endColour}";
    wget ${url_vulnhub} -q -O machines_vuln_tmp;
    md5_vuln=$(md5sum machines_vulnhub | awk 'NF{print $1}');
    md5_vuln_tmp=$(md5sum machines_vuln_tmp | awk 'NF{print $1}');
    echo -e "\n ${yellowColour}[-]${endColour} ${grayColour}Checando md5sum: ${endColour} ${blueColour}${md5_vuln}${endColour} ${grayColour}-${endColour} ${greenColour}${md5_vuln_tmp}${endColour}";
    
    if [ "$md5_vuln" == "$md5_vuln_tmp" ]; then
      echo -e "\n ${yellowColour}[+]${endColour} ${purpleColour}Todo esta actualizado.${endColour}";
      rm machines_vuln_tmp;
    else
      echo -e "\n ${yellowColour}[+]${endColour}${grayColour} Actualizando...${endColour}";
      rm machines_vulnhub;
      mv machines_vuln_tmp machines_vulnhub;
      echo -e "\n ${yellowColour}[+]${endColour}${greenColour} Actualizacion completa.${endColour}"
    fi
  fi

  #revisando si existe las maquinas de HTB
  if [ ! -f machines_htb ]; then
    echo -e "\n ${yellowColour}[+]${endColour}${grayColour} Descargando máquinas de HackTheBox...${endColour}";
    wget ${url_htb} -q -O machines_htb; 
  else
    echo -e "\n ${yellowColour}[+] Comprobando actualizaciones de HackTheBox ...${endColour}";
    
    wget ${url_htb} -q -O machines_htb_tmp;
    md5_htb=$(md5sum machines_htb | awk 'NF{print $1}');
    md5_htb_tmp=$(md5sum machines_htb_tmp | awk 'NF{print $1}');
    echo -e "\n ${yellowColour}[-]${endColour} ${grayColour}Checando md5sum: ${endColour} ${blueColour}${md5_htb}${endColour} ${grayColour}-${endColour} ${greenColour}${md5_htb_tmp}${endColour}";

    if [ "$md5_htb" == "$md5_htb_tmp" ]; then
      echo -e "\n ${yellowColour}[+]${endColour} ${purpleColour}Todo esta actualizado.${endColour}";
      rm machines_htb_tmp;
    else
      echo -e "\n ${yellowColour}[+]${endColour}${grayColour} Actualizando...${endColour}";
      rm machines_htb;
      mv machines_htb_tmp machines_htb;
      echo -e "\n ${yellowColour}[+]${endColour}${greenColour} Actualizacion completa.${endColour}"
    fi
  fi
}
# funcion para buscar por nombre
function searchByName()
{
  nameMachine="$1";
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Buscando por nombre de la maquina:${endColour}${grayColour} ${nameMachine}${endColour}\n";
  output="$(cat machines_htb | awk "BEGIN{IGNORECASE=1}/${nameMachine},/,/,Si/" | sed 's/,/,\n/g' | grep -v "Si" | tr -d '"')";
  if [ -n "$output" ]; then
    readarray -t -d ',' info_machine <<< "$(cat machines_htb | awk "BEGIN{IGNORECASE=1}; /${nameMachine},/,/,Si/" | sed 's/,/,\n/g' | grep -v "Si" | tr -d '"')";
    imprime_maquina "${info_machine[@]}";
  else
    echo -e "\n ${redColour} No existen maquinas con ese nombre${endColour}";
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
  1) searchByName $nameMachine;;
  2) updateFiles;;
  3) helpPanel;;
  *) catch_default;;
esac;


# Terminando ejecucion.
exit_tool 1;

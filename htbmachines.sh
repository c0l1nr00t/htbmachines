#!/bin/bash

#Variables globales.
url_htb="https://docs.google.com/spreadsheets/u/0/d/1dzvaGlT_0xnT-PGO27Z_4prHgA8PHIpErmoWdlUrSoA/gviz/tq?tqx=out:html";
url_vulnhub="https://docs.google.com/spreadsheets/u/0/d/1dzvaGlT_0xnT-PGO27Z_4prHgA8PHIpErmoWdlUrSoA/gviz/tq?tqx=out:html";
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
  echo -e "\n ${yellowColour}[!]${endColour} ${redColour}Saliendo ... ${endColour} \n";
  hola_cursor;  
  exit 1;
}

# Funcionalidades del sistema

#Panel de ayuda
function helpPanel()
{
  echo -e "\n ${yellowColour}[?]${endColour}${grayColour}Panel de ayuda${endColour}${grayColour}:${endColour}\n";
  echo -e "\n\t${yellowColour}-h: ${endColour}${grayColour}Muestra este panel de ayuda.${endColour}\n";
}


# Logica del programa
adios_cursor;
banner;

# Options
while getopts "m:h" arg; do
  case $arg in 
    m)nameMachine=$OPTARG;let counter+=1;;
  esac done;

#Valuacion de opciones
case $counter in
  1) searchByName;;
  0) helpPanel;;
  *) echo -e"\n${redColour}No es una opcion correcta${endColour}\n"; helpPanel;;
esac;


# Terminando ejecucion.
hola_cursor;
exit 0;

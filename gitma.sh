#!/bin/bash

red='\e[31m'
green='\e[32m'
yello='\e[33m'
blue='\e[34m'
clear='\e[0m'

color_red(){
  echo -ne $red$1$clear
}
color_green(){
	echo -ne $green$1$clear
}
color_yellow(){
  echo -ne $yellow$1$clear
}
color_blue(){
	echo -ne $blue$1$clear
}

run_jupyter() {
     echo ""
     echo "Starting jupyter"
     source /opt/conda/bin/activate \
  && conda activate gitma \
  && jupyter notebook \
           --notebook-dir=./src/demo_notebooks/ \
           --ip='*' \
           --port=8888 \
           --no-browser \
           --allow-root
     conda deactivate 
}

update_gitma() {
     echo ""
     echo "Updating GitMA"
     source /opt/conda/bin/activate \
  && conda activate gitma \
  && pip install --upgrade git+https://github.com/forTEXT/gitma \
  && conda deactivate
}

reinstall_demo(){
     echo ""
     echo "Deleting old files"
     rm -rf ./src
     source /opt/conda/bin/activate \
  && conda activate gitma \
  && echo "Cloning GitMA demo files"; git clone https://github.com/forTEXT/gitma.git ./src \
  && conda deactivate
}

press_enter() {
  echo ""
  echo -n "	Press Enter to continue "
  read
  clear
}

incorrect_selection() {
  echo "Incorrect selection! Try again."
}

print_logo(){
echo -ne "  
 _______    ________  _________  ___ __ __   ________      
/______/\\  /_______/\\/________/\\/__//_//_/\\ /_______/\\     
\\::::__\\/__\\__.::._\\/\\__.::.__\\/\\::\\| \\| \\ \\\\::: _  \\ \\    
 \\:\\ /____/\\  \\::\\ \\    \\::\\ \\   \\:.      \\ \\\\::(_)  \\ \\   
  \\:\\\\_  _\\/  _\\::\\ \\__  \\::\\ \\   \\:.\\-/\\  \\ \\\\:: __  \\ \\  
   \\:\\_\\ \\ \\ /__\\::\\__/\\  \\::\\ \\   \\. \\  \\  \\ \\\\:.\\ \\  \\ \\ 
    \\_____\\/ \\________\\/   \\__\\/    \\__\\/ \\__\\/ \\__\\/\\__\\/ 


    "                                                           
}

until [ "$selection" = "0" ]; do
  clear
  print_logo
  echo -ne "
    $(color_red 'https://github.com/forTEXT/gitma')


    $(color_blue 1):  Run jupyter
    $(color_blue 2):  Update GitMA
    $(color_blue 3):  Reinstall demo files (all changes will be lost)
 
    $(color_red 0):  Exit

    $(color_blue Enter selection): "
  read selection

  case $selection in
    1 ) clear ; run_jupyter ; press_enter ;;
    2 ) clear ; update_gitma ; press_enter ;;
    3 ) clear ; reinstall_demo ; press_enter ;;
    0 ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done

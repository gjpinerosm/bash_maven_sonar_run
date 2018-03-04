#!/bin/bash
url=(https://github.com/gitblit/gitblit.git)
urlBase=(/Users/pinergio/Documentos/Proyectos)
pathProyectos=(/AppiumDemo-master)

imprimirArray=(${urlBase[0]}${pathProyectos[@]})
numeroElementos=${#pathProyectos[@]}

whiptail --title "Generar mvn y sonar" --msgbox "Deseas iniciar el escaneo?" 8 78
for ((i=0; i<numeroElementos; i++));
do
	echo "Iniciando proceso... "
	cd /root/IdeaProjects
	rm -rf gitblit
	echo "EL path de url es: ${imprimirArray[i]}"
	cd ${imprimirArray[i]}	
	echo "Iniciando descarga/actualizacion de proyecto git"
	git clone https://github.com/gitblit/gitblit.git
	echo "Termina descarga/actualizacion de proyecto git"
	rm -rf gitblit.git
	echo "------ Inicia construcción de proyecto ------"
	mvn clean install
	echo "------ Termina construcción de proyecto ------"
	echo "------ Inicia escaneo de sonar ------"
	mvn sonar:sonar
	echo "------ Termina escaneo de sonar ------"
	cd ..
	echo $i
done | whiptail --gauge "Iniciando ejecución: MVN" 6 50 0 || echo "Error al intentar ejecucion"

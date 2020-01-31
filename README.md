# Appalyser
Código simples para analisar aplicativos android.


# Instalação

## Windows 10

**Windows Subsytem for Linux**
- Instale Windows Subsystem for Linux
- Vá até o Windows Features e habilite o Windows Subsystem for Linux.
- Após o computador ter reiniciado, instale a shell Kali Linux via Microsoft Store.

>**Importante**
Para acessar os sistema de arquivos do Windows utilizando a sua shell Linux, primeiro monte o diretório e depois mantenha em mente que o seu sistema de arquivos Windows estará no diretório montado. 
Por exemplo:
Para acessar o diretório **C:\Program Files\7-Zip** via shell, usamos `mount /mnt/c`. Dessa forma, o diretório acima pode ser acessado com o caminho **/mnt/c/Program Files/7-Zip**.
 
**Dependências**
- Comece atualizando o seu subsystem:
	- sudo apt-get update
	- sudo apt-get upgrade
- Cheque se possui Java instalado:
	- java --version
- Caso não possua:
	- sudo apt-get install openjdk-8-jdk
	- sudo apt-get install default-jdk
- Instale a útima versão do apktool:
	- export apktool_version=\`curl -s https://bitbucket.org/iBotPeaches/apktool/downloads/ | grep "href=\"/iBotPeaches/apktool/downloads/apktool_" | head -1 | cut -d ">" -f 2 | cut -d "<" -f 1\`

	- sudo -E sh -c 'wget https://bitbucket.org/iBotPeaches/apktool/downloads/$apktool_version -O /usr/local/bin/apktool.jar'

	- sudo chmod +r /usr/local/bin/apktool.jar

	- sudo sh -c 'wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O /usr/local/bin/apktool'

	- sudo chmod +x /usr/local/bin/apktool



## Linux

**Dependências**
- Comece atualizando o seu sistema:
	- sudo apt-get update
	- sudo apt-get upgrade
- Cheque se possui Java instalado:
	- java --version
- Caso não possua:
	- sudo apt-get install openjdk-8-jdk
	- sudo apt-get install default-jdk
- Instale a útima versão do apktool:
	- export apktool_version=\`curl -s https://bitbucket.org/iBotPeaches/apktool/downloads/ | grep "href=\"/iBotPeaches/apktool/downloads/apktool_" | head -1 | cut -d ">" -f 2 | cut -d "<" -f 1\`

	- sudo -E sh -c 'wget https://bitbucket.org/iBotPeaches/apktool/downloads/$apktool_version -O /usr/local/bin/apktool.jar'

	- sudo chmod +r /usr/local/bin/apktool.jar

	- sudo sh -c 'wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O /usr/local/bin/apktool'

	- sudo chmod +x /usr/local/bin/apktool

## Utilização

`chmod +x appalyser.sh`
`./appalyser.sh <PATH do apk>`

Enjoy :)

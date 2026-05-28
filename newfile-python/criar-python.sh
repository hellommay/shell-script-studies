#!/bin/bash

# nome do projeto
read -rp "Nome do projeto: " projeto

# criar e entrar na pasta
mkdir "$projeto"

cd "$projeto" || exit

# criando e ativando ambiente virtual
python3 -m venv venv

# shellcheck disable=SC1091
source venv/bin/activate

# estrutura basica
mkdir src tests

touch README.md
touch .gitignore
touch src/main.py

#instalando libs iniciais e gerando requeriments
pip install requests

pip freeze > requirements.txt

#conteudo dentro do .gitignore
cat > .gitignore <<EOF
venv/
__pycache__/
*.pyc
.env
.DS_Store
EOF


echo "Projeto Python criado com sucesso. "
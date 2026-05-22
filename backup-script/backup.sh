#!/bin/bash
set -e

# configuracao
SOURCE_DIR="$HOME/Dev/Projetos/"

BACKUP_DIR="./backups"

LOG_DIR="./logs"

DATE=$(date +"%d-%m-%Y_%H-%M-%S")

BACKUP_NAME="backup_$DATE.tar.gz"

LOG_FILE="$LOG_DIR/backup.log"

MAX_BACKUPS=5

#criando pastas
mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"

#verificando se a origem existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "[$DATE] ERRO: pasta origem não encontrada." >> "$LOG_FILE"
    echo "Pasta origem não encontrada."
    exit 1
fi 

#iniciar backup
echo "[$DATE] Iniciando backup..." >> "$LOG_FILE"

# criando backup
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR"

# validando backup
if tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR"; then
    SIZE=$(du -h "$BACKUP_DIR/$BACKUP_NAME" | cut -f1)

    echo "[$DATE] Backup criado com sucesso." >> "$LOG_FILE"
    echo "[$DATE] Tamanho do backup: $SIZE" >> "$LOG_FILE"

    echo "Backup realizado com sucesso."
    echo "Arquivo: $BACKUP_NAME"
    echo "Tamanho: $SIZE"

else
    echo "[$DATE] ERRO ao criar backup." >> "$LOG_FILE"
    echo "Erro ao criar backup."
    exit 1
fi

# remocao de backups antigos

TOTAL_BACKUPS=$(ls -1 "$BACKUP_DIR" | wc -l)

if [ "$TOTAL_BACKUPS" -gt "$MAX_BACKUPS" ]; then
    
    REMOVE=$(($TOTAL_BACKUPS - $MAX_BACKUPS))

    ls -1t "$BACKUP_DIR" | tail -n "$REMOVE" | while read FILE
    do
       rm "$BACKUP_DIR/$FILE"
       echo "[$DATE] Backup antigo removido: $FILE" >> "$LOG_FILE"
    done
fi

# finalizando
echo "[$DATE] Processo finalizado." >> "$LOG_FILE"
# Backup Validator

Esse script valida a execução do backup através da data de modificação do arquivo de log. Se o arquivo de log não foi modificado por mais de 2 dias, o plugin gera um alarme.

## Instalação

1. Inclua o arquivo no diretorio ../usr/lib/check_mk_agent/local/
2. Dar permissão de execução chmod +x error_catcher_counter.sh


## Exemplo do retorno
Se o status estiver OK,

    All ok with the backup

caso contrário,

    4 days without backup

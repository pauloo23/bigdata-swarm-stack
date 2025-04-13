#!/bin/bash
set -e

# Inicializa o serviço Superset em segundo plano
echo "Iniciando servidor Superset..."
/usr/bin/run-server.sh &
SERVER_PID=$!

# Aguarda o serviço estar disponível com timeout
echo "Aguardando o Superset iniciar..."
RETRY=0
MAX_RETRY=30
until curl -s http://localhost:9777/health > /dev/null || [ $RETRY -eq $MAX_RETRY ]; do
  echo "Esperando Superset ficar disponível... ($RETRY/$MAX_RETRY)"
  sleep 5
  RETRY=$((RETRY+1))
done

if [ $RETRY -eq $MAX_RETRY ]; then
  echo "Timeout ao aguardar o Superset iniciar!"
  exit 1
fi

echo "Criando usuário admin..."
echo "Usuário: ${ADMIN_USERNAME}"
echo "Email: ${ADMIN_EMAIL}"

superset fab create-admin \
    --username "${ADMIN_USERNAME}" \
    --firstname "${ADMIN_FIRSTNAME}" \
    --lastname "${ADMIN_LASTNAME}" \
    --email "${ADMIN_EMAIL}" \
    --password "${ADMIN_PASSWORD}" || true

echo "Atualizando banco de dados..."
superset db upgrade

# Carrega exemplos apenas se LOAD_EXAMPLES for true
if [ "${LOAD_EXAMPLES}" = "true" ]; then
  echo "Carregando exemplos..."
  superset load_examples || true
else
  echo "Pulando carregamento de exemplos..."
fi

echo "Inicializando o Superset..."
superset init

echo "Superset configurado e pronto para uso!"

# Espera pelo processo do servidor - isto manterá o contêiner rodando
wait $SERVER_PID
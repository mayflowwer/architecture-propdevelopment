#!/bin/bash
USERS=("user1" "user2")
CLUSTER_NAME="kubernetes"
CA_CERT="/etc/kubernetes/pki/ca.crt"
CA_KEY="/etc/kubernetes/pki/ca.key"

if [ ! -r "$CA_CERT" ] || [ ! -r "$CA_KEY" ]; then
  echo " Certificate problem found"
  exit 1
fi

for USER in "${USERS[@]}"; do
  echo "=== Создание пользователя: $USER ==="
  
  openssl genrsa -out ${USER}.key 2048
  echo "✅ Приватный ключ создан: ${USER}.key"
  
  openssl req -new -key ${USER}.key -out ${USER}.csr \
    -subj "/CN=${USER}/O=developers"
  echo " CSR создан: ${USER}.csr"
  
  openssl x509 -req -in ${USER}.csr \
    -CA ${CA_CERT} \
    -CAkey ${CA_KEY} \
    -CAcreateserial \
    -out ${USER}.crt -days 365
  echo " Сертификат подписан: ${USER}.crt"
  
  kubectl config set-credentials ${USER} \
    --client-certificate=${USER}.crt \
    --client-key=${USER}.key \
    --embed-certs=true
  echo "Пользователь добавлен в kubeconfig"
  
  kubectl config set-context ${USER}-context \
    --cluster=${CLUSTER_NAME} \
    --user=${USER}
  echo " Контекст создан: ${USER}-context"
  
  echo ""
done

echo "=== Созданные пользователи ==="
kubectl config get-users | grep -E "alice|bob"

echo ""
echo "=== Использование ==="
echo "Переключиться на alice:"
echo "  kubectl config use-context alice-context"
echo ""
echo "Переключиться на bob:"
echo "  kubectl config use-context bob-context"
echo ""
echo "Вернуться к admin:"
echo "  kubectl config use-context kubernetes-admin@kubernetes"
echo ""
echo "Проверить права пользователя:"
echo "  kubectl config use-context alice-context"
echo "  kubectl auth can-i get pods"
echo ""
echo " Готово! Теперь нужно создать RoleBindings для привязки ролей."
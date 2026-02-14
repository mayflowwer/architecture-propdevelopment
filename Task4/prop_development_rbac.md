| Роль                     | Права роли                                                                                        | Группы пользователей в организации |
| cluster-admin            | Полный доступ ко всем ресурсам кластера (verbs: *, resources: *)                                  | DevOps-инженер                     |
| cluster-editor           | create, update, delete, patch на deployments, services, configmaps, ingress во всех namespace     | DevOps-инженер                     |
|                          | get, list, watch на все ресурсы<br>НЕТ доступа к secrets                                          | Инженер по эксплуатации            |
| cluster-viewer           | get, list, watch на все ресурсы кластера (read-only)                                              | Инженер по эксплуатации            |
| secrets-manager          | get, list, create, update, delete на secrets во всех namespace<br>get, list, watch на configmaps  | DevOps-инженер, Специалист по ИБ   |
| developer                | get, list, watch на pods, services, deployments в namespace dev                                   | Разработчик                        |
|                          | create, update, delete на deployments, services, configmaps в namespace dev                       |                                    |
|                          | logs и exec в pods namespace development                                                          | Разработчик                        |
| monitoring-viewer        | get, list, watch на nodes, pods, services, metrics во всех namespace                              | Инженер по эксплуатации            |
| namespace-admin-team-a   | Полный доступ ко всем ресурсам в namespace team-a (verbs: *, resources: *)                        | Команда разработки A               |
| namespace-admin-team-b   | Полный доступ ко всем ресурсам в namespace team-b (verbs: *, resources: *)                        | Команда разработки B               |
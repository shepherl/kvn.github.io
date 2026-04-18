#!/bin/bash

# 1. ID расширения из твоей ссылки
EXT_ID="gcknhkkoolaabfmlnjonogaaifnjlfnp"

# 2. Формируем актуальную прямую ссылку
# Мы используем универсальный шаблон Google API
INSTALL_URL="https://clients2.google.com/service/update2/crx?response=redirect&prodchannel=stable&acceptformat=crx2,crx3&x=id%3D${EXT_ID}%26installsource%3Dondemand%26uc"

# 3. Визуальное уведомление
osascript -e 'display notification "Подготовка к установке расширения..." with title "KVN Installer" sound name "Glass"'

echo "--- Проверка готовности ---"

# 4. Диалог с пользователем
ANSWER=$(osascript -e 'display dialog "Установить расширение FoxyProxy в Google Chrome?" buttons {"Отмена", "Установить"} default button "Установить" with title "Настройка прокси"' -e 'button returned of result')

if [ "$ANSWER" = "Установить" ]; then
    echo "🌐 Открываю прямую ссылку в Chrome..."
    
    # Пытаемся открыть в Хроме. Если его нет, открываем в браузере по умолчанию (но установка сработает только в Chromium)
    open -a "Google Chrome" "$INSTALL_URL" || open "$INSTALL_URL"
    
    # 5. Подсказка, что делать дальше
    sleep 1
    osascript -e 'display dialog "В Chrome появилось окно подтверждения. Нажми «Добавить расширение» (Add extension), чтобы закончить." buttons {"Ок"} default button "Ок"'
else
    echo "❌ Установка отменена пользователем."
fi

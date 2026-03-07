#!/bin/bash

# Автocommit при изменении файлов
echo "Запуск автокоммита... Нажмите Ctrl+C для остановки"

while true; do
    # Ждём изменения файлов
    find src public -type f -mmin -1 2>/dev/null | head -1 | while read file; do
        if [ -n "$file" ]; then
            echo "Изменения обнаружены в: $file"
            git add -A
            git diff --cached --quiet || git commit -m "Auto-commit: $(date '+%H:%M:%S')"
            git push origin main 2>/dev/null && echo "✓ Push выполнен" || echo "✗ Push не удался (проверьте авторизацию)"
            sleep 5
        fi
    done
    sleep 2
done

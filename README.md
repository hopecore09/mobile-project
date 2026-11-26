# mobile-project

Два решения в одном репозитории:

- `packages/custom_archiver` — собственный алгоритм архивации и распаковки на чистом Dart (без Flutter) с потоковым API.
- `apps/file_manager` — файловый менеджер для Android на Flutter, использует `custom_archiver`.

```
packages/
  custom_archiver/   # алгоритм, формат архива, API
apps/
  file_manager/      # Flutter-приложение (появится позже)
```

Формат архива описан в [packages/custom_archiver/FORMAT.md](packages/custom_archiver/FORMAT.md).

<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Інформація про віртуальну машину Azure</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #0078d4;
        }
        .info-item {
            margin: 15px 0;
            padding: 10px;
            background-color: #f8f9fa;
            border-left: 4px solid #0078d4;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Інформація про віртуальну машину Azure</h1>
        
        <div class="info-item">
            <strong>Назва:</strong> ${vm_name}
        </div>
        
        <div class="info-item">
            <strong>Розмір:</strong> ${vm_size}
        </div>
        
        <div class="info-item">
            <strong>Локація:</strong> ${vm_location}
        </div>
        
        <div class="info-item">
            <strong>Публічна IP-адреса:</strong> ${public_ip}
        </div>
        
        <div class="info-item">
            <strong>Статус:</strong> Запущено та працює
        </div>
        
        <div class="info-item">
            <strong>Сервіс:</strong> Nginx успішно встановлено та налаштовано
        </div>
    </div>
</body>
</html>
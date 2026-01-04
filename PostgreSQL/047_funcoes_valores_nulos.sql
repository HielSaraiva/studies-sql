-- Retorne um valor alternativo se houver um valor nulo
SELECT COALESCE(phone, 'Não tem')
FROM owner;
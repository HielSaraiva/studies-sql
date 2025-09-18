DELETE FROM tabela_simples;

-- Comumente usada com WHERE <condição>
DELETE FROM tabela_simples
WHERE id = 1; -- É possível usar `id` para acessar o identificador (útil quando o identifacor usa uma palavra reservada)

/*
- É possível usar a função TRUNCATE, mas ela não permite ROLLBACK.
- Ela é consideravelmente mais rápida, pois deleta todas as tuplas de uma vez
- Se a tabela tiver um id incremental, o MySQL já reinicia o contador automaticamente
*/
TRUNCATE TABLE tabela_simples;

Endpoints:

- Usuários: 
-- CREATE-POST: http://localhost:3333/usuarios 
(JSON exemplo: {
	"id_usuario": 2,
	"nome": "robertinha",
	"email": "robertinha@gmail.com",
	"senha": "123415612",
	"dt_nascimento": "01/05/2025 00:00:00",
	"tipo_conta": "N"
})  

-- SELECT-*-GET: http://localhost:3333/usuarios 

-- SELECT-ID-GET: http://localhost:3333/usuarios/:id_usuario 

-- UPDATE-ID-PUT: http://localhost:3333/usuarios/:id_usuario
(JSON exemplo: {
	"id_usuario": 2,
	"nome": "bbbbbbbb",
	"email": "bbbbbb@gmail.com",
	"senha": "123415612",
	"dt_nascimento": "01/05/2025 00:00:00",
	"tipo_conta": "N"
})  

-- DELETE-ID-DELETE: http://localhost:3333/usuarios/:id_usuario
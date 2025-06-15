const { Router } = require("express");
const usuarioController = require("./controllers/usuarioController");

const routes = Router();

routes.post('/usuarios', usuarioController.store);
routes.get("/usuarios", usuarioController.index);
routes.get("/usuarios/:id_usuario", usuarioController.show)
routes.put("/usuarios/:id_usuario", usuarioController.update)
routes.delete("/usuarios/:id_usuario", usuarioController.delete)

module.exports = routes;

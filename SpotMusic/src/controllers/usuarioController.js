const { where } = require("sequelize");
const { Usuario } = require("../models");
const usuario = require("../models/usuario");

class UsuarioController {

  // Cria novo usuário
  async store(req, res) {
    try {
      const { nome, email, senha, dt_nascimento, tipo_conta } = req.body;

      const usuarioAllreadyExists = await Usuario.findOne({ where: { email } });

      if (usuarioAllreadyExists) {
        return res.status(400).json({ message: "Esse usuário já existe!" });
      }

      if (!nome || !email || !senha || !dt_nascimento) {
        return res
          .status(400)
          .json({
            message:
              "Nome, e-mail, senha e data de nascimento são obrigatórios!",
          });
      }

      const createdUser = await Usuario.create({
        nome: nome,
        email: email,
        senha: senha,
        dt_nascimento: dt_nascimento,
        tipo_conta: tipo_conta,
      });

      return res.status(200).json(createdUser);
    } catch (error) {
      return res.status(400).json({ message: "Falha ao cadastrar usuário!" });
    }
  }

  // Lista todos os usuários
  async index(req, res) {
    try {
      const usuarios = await Usuario.findAll();

      return res.status(200).json(usuarios);
    } catch (error) {
      return res.status(400).json({ message: "Falha ao listar usuários!" });
    }
  }

  // Encontra usuário pelo ID_USUARIO
  async show(req, res) {
    try {
      const { id_usuario } = req.params;

      const usuario = await Usuario.findByPk(id_usuario);

      if (!usuario) {
        return res.status(404).json({ message: "Usuário não encontrado!" + id_usuario + "  " + usuario });
      }

      return res.status(200).json(usuario);
    } catch (error) {
      return res.status(400).json({ message: "Falha ao encontrar o usuário informado!" });
    }
  }

  async update(req, res){
    try {
        const {id_usuario} = req.params;

        const { nome, email, senha, dt_nascimento, tipo_conta } = req.body;

        await Usuario.update(
            {nome, email, senha, dt_nascimento, tipo_conta},
            {where: {
                id_usuario: id_usuario
            }}
        )

        return res.status(200).json({message: "Usuário Atualizado!"})
    } catch (error) {
        return res.status(400).json({ message: "Falha ao editar o usuário!" });
    }
  }

  async delete(req, res){
    try {
        const {id_usuario} = req.params;

        // Colocar validações aqui

        await Usuario.destroy(
            {where: {
                id_usuario: id_usuario
            }}
        )

        return res.status(200).json({message: "Usuário Excluído!"})
    } catch (error) {
        return res.status(400).json({ message: "Falha ao excluír o usuário!" });
    }
  }

}

module.exports = new UsuarioController();

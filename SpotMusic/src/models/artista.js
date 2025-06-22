'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Artista extends Model {
    static associate(models) {
      // associações podem ser definidas aqui
    }
  }
  Artista.init({
    id_artista: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    nome: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    nacionalidade: DataTypes.STRING(50)
  }, {
    sequelize,
    modelName: 'Artista',
    tableName: 'artista',
  });
  return Artista;
};

'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Musica extends Model {
    static associate(models) {
      Musica.belongsTo(models.Album, { foreignKey: 'id_album' });
      Musica.belongsTo(models.Artista, { foreignKey: 'id_artista' });
    }
  }
  Musica.init({
    id_musica: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    titulo: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    genero: DataTypes.STRING(50),
    id_album: DataTypes.INTEGER,
    id_artista: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'Musica',
    tableName: 'musica',
  });
  return Musica;
};

'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Playlist extends Model {
    static associate(models) {
      Playlist.belongsTo(models.Usuario, { foreignKey: 'id_usuario' });
    }
  }
  Playlist.init({
    id_playlist: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    nome: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    id_usuario: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'Playlist',
    tableName: 'playlist',
  });
  return Playlist;
};

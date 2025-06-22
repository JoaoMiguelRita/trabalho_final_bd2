'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Album extends Model {
    static associate(models) {
      Album.belongsTo(models.Artista, { foreignKey: 'id_artista' });
    }
  }
  Album.init({
    id_album: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    titulo: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    ano_lancamento: DataTypes.INTEGER,
    id_artista: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'Album',
    tableName: 'album',
  });
  return Album;
};

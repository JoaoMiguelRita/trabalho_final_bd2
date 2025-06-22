'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class PlaylistMusica extends Model {
    static associate(models) {
      PlaylistMusica.belongsTo(models.Playlist, { foreignKey: 'id_playlist' });
      PlaylistMusica.belongsTo(models.Musica, { foreignKey: 'id_musica' });
    }
  }
  PlaylistMusica.init({
    id_playlist: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      allowNull: false
    },
    id_musica: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      allowNull: false
    },
    ordem: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'PlaylistMusica',
    tableName: 'playlist_musica',
  });
  return PlaylistMusica;
};

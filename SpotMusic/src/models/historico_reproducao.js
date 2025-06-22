'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class HistoricoReproducao extends Model {
    static associate(models) {
      HistoricoReproducao.belongsTo(models.Usuario, { foreignKey: 'id_usuario' });
      HistoricoReproducao.belongsTo(models.Musica, { foreignKey: 'id_musica' });
    }
  }
  HistoricoReproducao.init({
    id_usuario: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      allowNull: false
    },
    id_musica: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      allowNull: false
    },
    data_hora: {
      type: DataTypes.DATE,
      primaryKey: true,
      allowNull: false
    }
  }, {
    sequelize,
    modelName: 'HistoricoReproducao',
    tableName: 'historico_reproducao',
  });
  return HistoricoReproducao;
};

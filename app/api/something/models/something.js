'use strict';
const fs = require("fs")
const path = require("path")

/**
 * Read the documentation (https://strapi.io/documentation/v3.x/concepts/models.html#lifecycle-hooks)
 * to customize this model
 */

const pingBridgetown = () => {
  const filePath = path.resolve("/bridgetown/src", "_strapi")
  fs.writeFileSync(filePath, new Date().getTime())
}

module.exports = {
  lifecycles: {
    async afterCreate(data) {
      pingBridgetown()
    },

    async afterUpdate(data) {
      pingBridgetown()
    }
  },
};

const express = require('express');
const TaskController = require('../controllers/taskController');

const router = express.Router();
const taskController = new TaskController();

function setRoutes(app) {
    router.post('/tasks', taskController.createTask.bind(taskController));
    router.get('/tasks', taskController.getTasks.bind(taskController));
    router.put('/tasks/:id', taskController.updateTask.bind(taskController));
    router.delete('/tasks/:id', taskController.deleteTask.bind(taskController));

    app.use('/api', router);
}

module.exports = setRoutes;
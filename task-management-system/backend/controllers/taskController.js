class TaskController {
    constructor(Task) {
        this.Task = Task;
    }

    async createTask(req, res) {
        try {
            const task = new this.Task(req.body);
            await task.save();
            res.status(201).json(task);
        } catch (error) {
            res.status(400).json({ message: error.message });
        }
    }

    async getTasks(req, res) {
        try {
            const tasks = await this.Task.find();
            res.status(200).json(tasks);
        } catch (error) {
            res.status(500).json({ message: error.message });
        }
    }

    async updateTask(req, res) {
        try {
            const { id } = req.params;
            const task = await this.Task.findByIdAndUpdate(id, req.body, { new: true });
            if (!task) {
                return res.status(404).json({ message: 'Task not found' });
            }
            res.status(200).json(task);
        } catch (error) {
            res.status(400).json({ message: error.message });
        }
    }

    async deleteTask(req, res) {
        try {
            const { id } = req.params;
            const task = await this.Task.findByIdAndDelete(id);
            if (!task) {
                return res.status(404).json({ message: 'Task not found' });
            }
            res.status(204).send();
        } catch (error) {
            res.status(500).json({ message: error.message });
        }
    }
}

export default TaskController;
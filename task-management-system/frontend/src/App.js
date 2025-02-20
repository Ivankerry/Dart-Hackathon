import React, { useEffect, useState } from 'react';
import TaskComponent from './components/TaskComponent';

const App = () => {
    const [tasks, setTasks] = useState([]);

    useEffect(() => {
        fetchTasks();
    }, []);

    const fetchTasks = async () => {
        const response = await fetch('/api/tasks');
        const data = await response.json();
        setTasks(data);
    };

    const handleTaskUpdate = async (updatedTask) => {
        const response = await fetch(`/api/tasks/${updatedTask._id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(updatedTask),
        });
        if (response.ok) {
            fetchTasks();
        }
    };

    const handleTaskDelete = async (taskId) => {
        const response = await fetch(`/api/tasks/${taskId}`, {
            method: 'DELETE',
        });
        if (response.ok) {
            fetchTasks();
        }
    };

    return (
        <div>
            <h1>Task Management System</h1>
            <div>
                {tasks.map(task => (
                    <TaskComponent 
                        key={task._id} 
                        task={task} 
                        onUpdate={handleTaskUpdate} 
                        onDelete={handleTaskDelete} 
                    />
                ))}
            </div>
        </div>
    );
};

export default App;
import React, { useState } from 'react';
import { Draggable } from 'react-beautiful-dnd';

const TaskComponent = ({ task, index, onDelete, onUpdate }) => {
    const [isEditing, setIsEditing] = useState(false);
    const [updatedTask, setUpdatedTask] = useState(task.title);

    const handleUpdate = () => {
        onUpdate(task.id, updatedTask);
        setIsEditing(false);
    };

    return (
        <Draggable draggableId={task.id} index={index}>
            {(provided) => (
                <div
                    ref={provided.innerRef}
                    {...provided.draggableProps}
                    {...provided.dragHandleProps}
                    className="task"
                >
                    {isEditing ? (
                        <div>
                            <input
                                type="text"
                                value={updatedTask}
                                onChange={(e) => setUpdatedTask(e.target.value)}
                            />
                            <button onClick={handleUpdate}>Save</button>
                        </div>
                    ) : (
                        <div>
                            <h3>{task.title}</h3>
                            <p>{task.description}</p>
                            <button onClick={() => setIsEditing(true)}>Edit</button>
                            <button onClick={() => onDelete(task.id)}>Delete</button>
                        </div>
                    )}
                </div>
            )}
        </Draggable>
    );
};

export default TaskComponent;
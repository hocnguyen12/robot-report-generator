'use client';
import { useState } from 'react';
import { DELAYS_ENABLED, DELAYS } from '../config/delays';

interface Todo {
  id: number;
  text: string;
  completed: boolean;
}

export default function Todo() {
  const [todos, setTodos] = useState<Todo[]>([]);
  const [inputText, setInputText] = useState('');

  const addTodo = () => {
    if (inputText.trim()) {
      const action = () => {
        setTodos([...todos, { id: Date.now(), text: inputText.trim(), completed: false }]);
        setInputText('');
      };
      
      if (DELAYS_ENABLED) {
        setTimeout(action, DELAYS.TODO.ADD);
      } else {
        action();
      }
    }
  };

  const toggleTodo = (id: number) => {
    const action = () => {
      setTodos(
        todos.map((todo) =>
          todo.id === id ? { ...todo, completed: !todo.completed } : todo
        )
      );
    };

    if (DELAYS_ENABLED) {
      setTimeout(action, DELAYS.TODO.TOGGLE);
    } else {
      action();
    }
  };

  const deleteTodo = (id: number) => {
    const action = () => {
      setTodos(todos.filter((todo) => todo.id !== id));
    };

    if (DELAYS_ENABLED) {
      setTimeout(action, DELAYS.TODO.DELETE);
    } else {
      action();
    }
  };

  return (
    <div className="max-w-md mx-auto">
      <h1 className="text-2xl font-bold mb-4" data-testid="todo-header">Todo List</h1>
      <div className="flex mb-4">
        <input
          type="text"
          value={inputText}
          onChange={(e) => setInputText(e.target.value)}
          onKeyPress={(e) => e.key === 'Enter' && addTodo()}
          className="flex-1 p-2 border rounded-l focus:outline-none focus:ring-2 focus:ring-blue-500"
          placeholder="Add a new todo"
          data-testid="todo-input"
        />
        <button
          onClick={addTodo}
          className="px-4 py-2 bg-blue-500 text-white rounded-r hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500"
          data-testid="add-todo-button"
        >
          Add
        </button>
      </div>
      <ul className="space-y-2">
        {todos.map((todo) => (
          <li
            key={todo.id}
            className="flex items-center justify-between p-3 border rounded hover:bg-gray-50"
            data-testid={`todo-item-${todo.id}`}
          >
            <div className="flex items-center">
              <input
                type="checkbox"
                checked={todo.completed}
                onChange={() => toggleTodo(todo.id)}
                className="mr-3 h-5 w-5 text-blue-500 rounded focus:ring-blue-500"
                data-testid={`todo-checkbox-${todo.id}`}
              />
              <span
                className={`text-gray-800 ${todo.completed ? 'line-through text-gray-500' : ''}`}
                data-testid={`todo-text-${todo.id}`}
              >
                {todo.text}
              </span>
            </div>
            <button
              onClick={() => deleteTodo(todo.id)}
              className="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600 focus:outline-none focus:ring-2 focus:ring-red-500"
              data-testid={`todo-delete-${todo.id}`}
            >
              Delete
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
} 
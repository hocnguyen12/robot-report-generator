'use client';

import { useState } from 'react';
import Todo from './components/Todo';
import TextEditor from './components/TextEditor';
import Calculator from './components/Calculator';
import Notes from './components/Notes';

export default function Home() {
  const [activeTab, setActiveTab] = useState('todo');

  const tabs = [
    { id: 'todo', label: 'Todo List' },
    { id: 'editor', label: 'Text Editor' },
    { id: 'calculator', label: 'Calculator' },
    { id: 'notes', label: 'Notes' },
  ];

  return (
    <div className="max-w-2xl mx-auto">
      <div className="text-center mb-8">
        <h1 className="text-3xl font-bold text-gray-900 mb-2">Productivity Tools</h1>
        <p className="text-gray-600">A collection of useful tools to boost your productivity</p>
      </div>
      
      <div className="bg-white rounded-xl shadow-lg overflow-hidden">
        <div className="border-b border-gray-200">
          <nav className="flex -mb-px">
            {tabs.map((tab) => (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id)}
                className={`flex-1 py-4 px-6 text-center border-b-2 font-medium text-sm ${
                  activeTab === tab.id
                    ? 'border-blue-500 text-blue-600'
                    : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                }`}
              >
                {tab.label}
              </button>
            ))}
          </nav>
        </div>

        <div className="p-6">
          <div className="transition-all duration-300 ease-in-out">
            {activeTab === 'todo' && <Todo />}
            {activeTab === 'editor' && <TextEditor />}
            {activeTab === 'calculator' && <Calculator />}
            {activeTab === 'notes' && <Notes />}
          </div>
        </div>
      </div>
    </div>
  );
} 
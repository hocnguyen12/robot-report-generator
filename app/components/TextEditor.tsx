'use client';

import { useState } from 'react';
import { DELAYS_ENABLED, DELAYS } from '../config/delays';

interface Message {
  type: 'success' | 'error';
  text: string;
}

export default function TextEditor() {
  const [content, setContent] = useState('');
  const [fileName, setFileName] = useState('untitled.txt');
  const [message, setMessage] = useState<Message | null>(null);

  const showMessage = (type: 'success' | 'error', text: string) => {
    setMessage({ type, text });
    setTimeout(() => setMessage(null), 3000);
  };

  const handleSave = () => {
    try {
      // Validate filename
      if (!fileName.trim()) {
        showMessage('error', 'Please enter a file name');
        return;
      }

      const action = () => {
        // Create and download the file
        const blob = new Blob([content], { type: 'text/plain' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = fileName;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);

        showMessage('success', 'File saved successfully');
      };

      if (DELAYS_ENABLED) {
        setTimeout(action, DELAYS.TEXT_EDITOR.SAVE);
      } else {
        action();
      }
    } catch (error) {
      showMessage('error', 'Failed to save file');
      console.error('Save error:', error);
    }
  };

  const handleClear = () => {
    try {
      const action = () => {
        setContent('');
        showMessage('success', 'Editor content cleared');
      };

      if (DELAYS_ENABLED) {
        setTimeout(action, DELAYS.TEXT_EDITOR.CLEAR);
      } else {
        action();
      }
    } catch (error) {
      showMessage('error', 'Failed to clear content');
      console.error('Clear error:', error);
    }
  };

  return (
    <div className="max-w-2xl mx-auto">
      <div className="p-4 border-b border-gray-200 bg-gray-50">
        <div className="flex items-center space-x-4">
          <div className="flex-1">
            <input
              type="text"
              value={fileName}
              onChange={(e) => setFileName(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              placeholder="Enter file name"
            />
          </div>
          <button
            onClick={handleSave}
            className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
          >
            <svg className="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4" />
            </svg>
            Save
          </button>
          <button
            onClick={handleClear}
            className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-gray-600 hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500"
          >
            <svg className="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
            </svg>
            Clear
          </button>
        </div>
        {message && (
          <div
            className={`mt-4 p-3 rounded-md ${
              message.type === 'success'
                ? 'bg-green-50 text-green-800'
                : 'bg-red-50 text-red-800'
            }`}
          >
            {message.text}
          </div>
        )}
      </div>
      <div className="p-4">
        <textarea
          value={content}
          onChange={(e) => setContent(e.target.value)}
          className="w-full h-96 p-4 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 font-mono text-sm"
          placeholder="Start typing..."
        />
      </div>
    </div>
  );
} 
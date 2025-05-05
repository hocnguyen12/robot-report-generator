'use client';

import { useState, useEffect } from 'react';
import { DELAYS_ENABLED, DELAYS } from '../config/delays';

interface Note {
  id: string;
  title: string;
  content: string;
  createdAt: string;
}

export default function Notes() {
  const [notes, setNotes] = useState<Note[]>([]);
  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');
  const [editingNote, setEditingNote] = useState<Note | null>(null);

  useEffect(() => {
    const loadNotes = () => {
      const savedNotes = localStorage.getItem('notes');
      if (savedNotes) {
        setNotes(JSON.parse(savedNotes));
      }
    };

    if (DELAYS_ENABLED) {
      setTimeout(loadNotes, DELAYS.NOTES.LOAD);
    } else {
      loadNotes();
    }
  }, []);

  const saveNotes = (newNotes: Note[]) => {
    setNotes(newNotes);
    localStorage.setItem('notes', JSON.stringify(newNotes));
  };

  const handleAddNote = () => {
    if (!title.trim() || !content.trim()) return;

    const newNote: Note = {
      id: Date.now().toString(),
      title,
      content,
      createdAt: new Date().toISOString(),
    };

    const action = () => {
      saveNotes([...notes, newNote]);
      setTitle('');
      setContent('');
    };

    if (DELAYS_ENABLED) {
      setTimeout(action, DELAYS.NOTES.ADD);
    } else {
      action();
    }
  };

  const handleDeleteNote = (id: string) => {
    const action = () => {
      saveNotes(notes.filter((note) => note.id !== id));
    };

    if (DELAYS_ENABLED) {
      setTimeout(action, DELAYS.NOTES.DELETE);
    } else {
      action();
    }
  };

  const handleEditNote = (note: Note) => {
    const action = () => {
      setEditingNote(note);
      setTitle(note.title);
      setContent(note.content);
    };

    if (DELAYS_ENABLED) {
      setTimeout(action, DELAYS.NOTES.EDIT);
    } else {
      action();
    }
  };

  const handleUpdateNote = () => {
    if (!editingNote) return;

    const updatedNotes = notes.map((note) =>
      note.id === editingNote.id
        ? { ...note, title, content, createdAt: new Date().toISOString() }
        : note
    );

    const action = () => {
      saveNotes(updatedNotes);
      setEditingNote(null);
      setTitle('');
      setContent('');
    };

    if (DELAYS_ENABLED) {
      setTimeout(action, DELAYS.NOTES.UPDATE);
    } else {
      action();
    }
  };

  return (
    <div className="space-y-6" data-testid="notes-app">
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <div className="space-y-4">
          <input
            type="text"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            placeholder="Note title"
            className="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            data-testid="note-title-input"
          />
          <textarea
            value={content}
            onChange={(e) => setContent(e.target.value)}
            placeholder="Note content"
            className="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 h-32"
            data-testid="note-content-input"
          />
          <button
            onClick={editingNote ? handleUpdateNote : handleAddNote}
            className="w-full px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
            data-testid={editingNote ? "update-note-button" : "add-note-button"}
          >
            {editingNote ? 'Update Note' : 'Add Note'}
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {notes.map((note) => (
          <div key={note.id} className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden" data-testid={`note-${note.id}`}>
            <div className="p-6">
              <h3 className="text-lg font-semibold text-gray-900 mb-2" data-testid={`note-title-${note.id}`}>{note.title}</h3>
              <p className="text-gray-600 mb-4 whitespace-pre-wrap" data-testid={`note-content-${note.id}`}>{note.content}</p>
              <p className="text-sm text-gray-400 mb-4" data-testid={`note-date-${note.id}`}>
                {new Date(note.createdAt).toLocaleString()}
              </p>
              <div className="flex space-x-3">
                <button
                  onClick={() => handleEditNote(note)}
                  className="px-3 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                  data-testid={`edit-note-button-${note.id}`}
                >
                  Edit
                </button>
                <button
                  onClick={() => handleDeleteNote(note.id)}
                  className="px-3 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
                  data-testid={`delete-note-button-${note.id}`}
                >
                  Delete
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
} 
'use client';

import { useState } from 'react';
import { DELAYS_ENABLED, DELAYS } from '../config/delays';

export default function Calculator() {
  const [display, setDisplay] = useState('0');
  const [equation, setEquation] = useState('');

  const handleNumber = (num: string) => {
    const action = () => {
      if (display === '0') {
        setDisplay(num);
      } else {
        setDisplay(display + num);
      }
    };

    if (DELAYS_ENABLED) {
      setTimeout(action, DELAYS.CALCULATOR.NUMBER);
    } else {
      action();
    }
  };

  const handleOperator = (op: string) => {
    const action = () => {
      setEquation(equation + display + op);
      setDisplay('0');
    };

    if (DELAYS_ENABLED) {
      setTimeout(action, DELAYS.CALCULATOR.OPERATOR);
    } else {
      action();
    }
  };

  const handleEquals = () => {
    const action = () => {
      try {
        const result = eval(equation + display);
        setDisplay(result.toString());
        setEquation('');
      } catch (error) {
        setDisplay('Error');
      }
    };

    if (DELAYS_ENABLED) {
      setTimeout(action, DELAYS.CALCULATOR.EQUALS);
    } else {
      action();
    }
  };

  const handleClear = () => {
    const action = () => {
      setDisplay('0');
      setEquation('');
    };

    if (DELAYS_ENABLED) {
      setTimeout(action, DELAYS.CALCULATOR.CLEAR);
    } else {
      action();
    }
  };

  return (
    <div className="max-w-sm mx-auto" data-testid="calculator">
      <div className="mb-4 bg-gray-50 rounded-lg p-4">
        <div data-testid="equation-display" className="text-right text-gray-500 text-sm h-6 font-mono">{equation}</div>
        <div data-testid="display" className="text-right text-3xl font-bold h-10 font-mono">{display}</div>
      </div>
      <div className="grid grid-cols-4 gap-2">
        <button
          data-testid="clear-button"
          onClick={() => handleClear()}
          className="col-span-2 bg-red-500 text-white p-3 rounded-lg font-medium hover:bg-red-600 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2"
        >
          C
        </button>
        <button
          data-testid="operator-divide"
          onClick={() => handleOperator('/')}
          className="bg-gray-100 p-3 rounded-lg font-medium hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2"
        >
          ÷
        </button>
        <button
          data-testid="operator-multiply"
          onClick={() => handleOperator('*')}
          className="bg-gray-100 p-3 rounded-lg font-medium hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2"
        >
          ×
        </button>
        {[7, 8, 9, '-'].map((num) => (
          <button
            key={num}
            data-testid={typeof num === 'number' ? `number-${num}` : `operator-subtract`}
            onClick={() => typeof num === 'number' ? handleNumber(num.toString()) : handleOperator(num)}
            className="bg-gray-50 p-3 rounded-lg font-medium hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2"
          >
            {num}
          </button>
        ))}
        {[4, 5, 6, '+'].map((num) => (
          <button
            key={num}
            data-testid={typeof num === 'number' ? `number-${num}` : `operator-add`}
            onClick={() => typeof num === 'number' ? handleNumber(num.toString()) : handleOperator(num)}
            className="bg-gray-50 p-3 rounded-lg font-medium hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2"
          >
            {num}
          </button>
        ))}
        {[1, 2, 3, '='].map((num) => (
          <button
            key={num}
            data-testid={typeof num === 'number' ? `number-${num}` : 'equals-button'}
            onClick={() => typeof num === 'number' ? handleNumber(num.toString()) : handleEquals()}
            className={`p-3 rounded-lg font-medium focus:outline-none focus:ring-2 focus:ring-offset-2 ${
              num === '='
                ? 'bg-blue-500 text-white hover:bg-blue-600 focus:ring-blue-500'
                : 'bg-gray-50 hover:bg-gray-100 focus:ring-gray-500'
            }`}
          >
            {num}
          </button>
        ))}
        <button
          data-testid="number-0"
          onClick={() => handleNumber('0')}
          className="col-span-2 bg-gray-50 p-3 rounded-lg font-medium hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2"
        >
          0
        </button>
        <button
          data-testid="number-decimal"
          onClick={() => handleNumber('.')}
          className="bg-gray-50 p-3 rounded-lg font-medium hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2"
        >
          .
        </button>
      </div>
    </div>
  );
} 
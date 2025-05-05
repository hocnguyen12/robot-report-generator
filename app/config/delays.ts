// Global configuration for delays
export const DELAYS_ENABLED = false;

// Delay durations in milliseconds
export const DELAYS = {
  // Todo component delays
  TODO: {
    ADD: 1500,
    TOGGLE: 1000,
    DELETE: 1200
  },
  // TextEditor component delays
  TEXT_EDITOR: {
    SAVE: 2000,
    CLEAR: 1500
  },
  // Calculator component delays
  CALCULATOR: {
    NUMBER: 500,
    OPERATOR: 800,
    EQUALS: 1500,
    CLEAR: 1000
  },
  // Notes component delays
  NOTES: {
    LOAD: 2000,
    ADD: 1500,
    DELETE: 1000,
    EDIT: 800,
    UPDATE: 1200
  }
}; 
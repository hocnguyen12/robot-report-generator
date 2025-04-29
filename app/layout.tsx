import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'Utility Collection',
  description: 'A tool application with intentional flaws for testing',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className="min-h-screen bg-gray-50">
        <div className="container mx-auto px-4 py-8">
          {children}
        </div>
      </body>
    </html>
  )
} 
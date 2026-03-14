import type { Metadata } from 'next';
import Home from './Home';

export const metadata: Metadata = {
    title: "Discover events and buy tickets"
}

export default function HomePage() {
    return <Home />
}
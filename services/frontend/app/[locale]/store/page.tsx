import type { Metadata } from 'next';

import { NO_INDEX_PAGE } from '@/constants/seo.constants';
import TicketDashboard from './TicketDashboard';


export const metadata: Metadata = {
    title: 'Ticket Management',
    ...NO_INDEX_PAGE
}

export default function TicketDashboardPage() {
    return <TicketDashboard />
}
// seed/seed_data.js
// Run with: node seed_data.js

const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore, FieldValue } = require('firebase-admin/firestore');
const serviceAccount = require('./serviceAccountKey.json');

const app = initializeApp({
    credential: cert(serviceAccount),
});

const db = getFirestore(app);

// --- VERIFIED DATA ---
// --- ⚠️ PLACEHOLDER markers = not yet confirmed, replace before real LGU use ---

const hotlines = [
    { name: 'MDRRMO Bulan', number: '0961 823 4132', category: 'emergency' },
    { name: 'Bulan Police Station (PNP)', number: '0919 829 2101', category: 'police' },
    { name: 'Bureau of Fire Protection - Bulan', number: '0930 138 2814', category: 'fire' },
    { name: 'Bulan Rural Health Unit', number: 'PLACEHOLDER - VERIFY', category: 'medical' },
    { name: 'Bulan Water District', number: 'PLACEHOLDER - VERIFY', category: 'utility' },
    { name: 'SORECO 1 (Electric Cooperative)', number: 'PLACEHOLDER - VERIFY', category: 'utility' },
];

const offices = [
    {
        name: 'Bulan Municipal Hall',
        barangay: 'Brgy. Aquino',
        lat: 12.6677,
        lng: 123.8775,
        contactNumber: 'PLACEHOLDER - VERIFY',
        hours: 'Mon–Fri, 8:00 AM – 5:00 PM',
    },
    {
        name: 'Bulan Rural Health Unit',
        barangay: 'Brgy. Aquino (T. De Castro St.)',
        lat: 12.6767,
        lng: 123.8750,
        contactNumber: 'PLACEHOLDER - VERIFY',
        hours: 'Mon–Fri, 8:00 AM – 5:00 PM',
    },
    {
        name: 'Bulan Police Station (PNP)',
        barangay: 'PLACEHOLDER - VERIFY ADDRESS',
        lat: 12.6677,
        lng: 123.8775,
        contactNumber: '0919 829 2101',
        hours: '24/7',
    },
    {
        name: 'Bureau of Fire Protection - Bulan',
        barangay: 'PLACEHOLDER - VERIFY ADDRESS',
        lat: 12.6677,
        lng: 123.8775,
        contactNumber: '0930 138 2814',
        hours: '24/7',
    },
];

const announcements = [
    {
        title: 'Padaraw Festival 2026',
        body: 'Join us as Bulan celebrates the Padaraw Festival on May 30! Stay tuned for full schedule of activities.',
        tag: 'EVENT',
        pinned: true,
    },
    {
        title: 'Community Advisory',
        body: 'PLACEHOLDER - add a real, current road advisory or community announcement here before presenting.',
        tag: 'ADVISORY',
        pinned: false,
    },
];

const notifications = [
    {
        title: 'Welcome to Bulan One App',
        body: 'Report issues, request services, and stay updated on Bulan news \u2014 all in one place.',
    },
    {
        title: 'Padaraw Festival is coming',
        body: 'Mark your calendars \u2014 Padaraw Festival 2026 starts May 30!',
    },
];

async function seedCollection(name, docs) {
    const batch = db.batch();
    docs.forEach((doc) => {
        const ref = db.collection(name).doc();
        const data = name === 'announcements' || name === 'notifications'
            ? { ...doc, createdAt: FieldValue.serverTimestamp() }
            : doc;
        batch.set(ref, data);
    });
    await batch.commit();
    console.log(`Seeded ${docs.length} documents into "${name}"`);
}

async function main() {
    await seedCollection('hotlines', hotlines);
    await seedCollection('offices', offices);
    await seedCollection('announcements', announcements);
    await seedCollection('notifications', notifications);
    console.log('Done.');
    process.exit(0);
}

main().catch((err) => {
    console.error('Seeding failed:', err);
    process.exit(1);
});
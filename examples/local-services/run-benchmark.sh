#!/usr/bin/env bash
# run-benchmark.sh — benchmark local services using vegeta
# Results match the 2026-02-19 baseline on Maxime's MacBook Pro (M3)
#
# Requirements:
#   - vegeta installed (go install github.com/tsenart/vegeta@latest)
#   - Services running locally (adjust HOST/PORTs below)
#
# Usage:
#   chmod +x run-benchmark.sh
#   ./run-benchmark.sh

set -euo pipefail

VEGETA="${VEGETA:-vegeta}"
DURATION="${DURATION:-30s}"

echo "=== Vegeta local-service benchmark ==="
echo "Duration: $DURATION per test"
echo ""

# ── Test 1: CRM Dashboard ──────────────────────────────────────────────
echo "▶ Test 1: CRM Dashboard (localhost:8080/) — 50 req/s"
echo "GET http://localhost:8080/" | \
  $VEGETA attack -rate=50 -duration="$DURATION" | \
  $VEGETA report -type=text
echo ""

# ── Test 2: CRM API /applications ─────────────────────────────────────
echo "▶ Test 2: CRM API /applications (localhost:8080/applications) — 30 req/s"
echo "GET http://localhost:8080/applications" | \
  $VEGETA attack -rate=30 -duration="$DURATION" | \
  $VEGETA report -type=text
echo ""

# ── Test 3: Life RAG Web UI ────────────────────────────────────────────
echo "▶ Test 3: Life RAG Web UI (localhost:8092/) — 20 req/s"
echo "GET http://localhost:8092/" | \
  $VEGETA attack -rate=20 -duration="$DURATION" | \
  $VEGETA report -type=text
echo ""

echo "=== Benchmark complete ==="

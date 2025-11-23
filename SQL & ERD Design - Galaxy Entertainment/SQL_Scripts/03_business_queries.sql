-- Artist ROI Analysis: Calculate return on investment for each artist
SELECT 
    a.artist_id,
    CONCAT(a.artist_f_name, ' ', a.artist_l_name) as artist_name,
    a.artist_status,
    COUNT(DISTINCT c.content_id) as content_count,
    SUM(c.stream_count) as total_streams,
    SUM(c.revenue_generated) as total_revenue,
    SUM(c.production_cost) as total_production_cost,
    (SUM(c.revenue_generated) - SUM(c.production_cost)) as net_profit,
    ROUND(((SUM(c.revenue_generated) - SUM(c.production_cost)) / NULLIF(SUM(c.production_cost), 0)) * 100, 2) as roi_percentage
FROM ARTISTS a
LEFT JOIN CONTENTS c ON a.artist_id = c.artist_id
GROUP BY a.artist_id, artist_name, a.artist_status
ORDER BY roi_percentage DESC;

-- Training ROI Analysis: Which training programs deliver best results?
SELECT 
    t.training_name,
    t.training_area,
    t.training_cost,
    t.success_rate,
    COUNT(DISTINCT e.artist_id) as artists_trained,
    AVG(c.stream_count) as avg_streams_post_training,
    AVG(c.revenue_generated) as avg_revenue_post_training,
    ROUND((AVG(c.revenue_generated) - t.training_cost) / NULLIF(t.training_cost, 0) * 100, 2) as training_roi
FROM TRAININGS t
LEFT JOIN ENROLLMENTS e ON t.training_id = e.training_id
LEFT JOIN ARTISTS a ON e.artist_id = a.artist_id
LEFT JOIN CONTENTS c ON a.artist_id = c.artist_id AND c.content_release > e.enrollment_start_date
GROUP BY t.training_id, t.training_name, t.training_area, t.training_cost, t.success_rate
ORDER BY training_roi DESC;

-- Market Revenue Performance with Rankings
SELECT 
    m.market_region,
    m.market_country,
    COUNT(DISTINCT mtc.content_id) as content_count,
    SUM(c.stream_count) as total_streams,
    SUM(c.revenue_generated) as total_revenue,
    ROUND(SUM(c.revenue_generated) / NULLIF(COUNT(DISTINCT mtc.content_id), 0), 2) as revenue_per_content,
    RANK() OVER (ORDER BY SUM(c.revenue_generated) DESC) as revenue_rank,
    ROUND((SUM(c.stream_count) / NULLIF(m.market_population, 0)) * 100, 4) as market_penetration_rate
FROM MARKETS m
JOIN MARKET_TARGETED_CONTENTS mtc ON m.market_id = mtc.market_id
JOIN CONTENTS c ON mtc.content_id = c.content_id
GROUP BY m.market_region, m.market_country, m.market_population
ORDER BY total_revenue DESC;

-- Fan Segmentation by Engagement and Value
SELECT 
    f.fan_region,
    f.fan_country,
    COUNT(f.fan_id) as total_fans,
    AVG(f.fan_engagement_score) as avg_engagement,
    COUNT(s.sale_id) as total_purchases,
    COALESCE(SUM(s.sale_total_amount), 0) as total_revenue,
    CASE 
        WHEN AVG(f.fan_engagement_score) >= 90 THEN 'Super Fan'
        WHEN AVG(f.fan_engagement_score) >= 75 THEN 'Engaged Fan'
        WHEN AVG(f.fan_engagement_score) >= 50 THEN 'Casual Fan'
        ELSE 'Low Engagement'
    END as fan_segment,
    ROUND(COALESCE(SUM(s.sale_total_amount), 0) / NULLIF(COUNT(f.fan_id), 0), 2) as revenue_per_fan
FROM FANS f
LEFT JOIN SALES s ON f.fan_id = s.fan_id AND s.sale_status = 'completed'
GROUP BY f.fan_region, f.fan_country
ORDER BY revenue_per_fan DESC;

-- Monthly Content Performance with Growth Rates
SELECT 
    DATE_FORMAT(c.content_release, '%Y-%m') as release_month,
    c.content_type,
    COUNT(c.content_id) as content_count,
    AVG(c.stream_count) as avg_streams,
    AVG(c.revenue_generated) as avg_revenue,
    SUM(c.revenue_generated) as monthly_revenue,
    LAG(SUM(c.revenue_generated)) OVER (ORDER BY DATE_FORMAT(c.content_release, '%Y-%m')) as prev_month_revenue,
    ROUND(
        ((SUM(c.revenue_generated) - LAG(SUM(c.revenue_generated)) OVER (ORDER BY DATE_FORMAT(c.content_release, '%Y-%m'))) 
        / NULLIF(LAG(SUM(c.revenue_generated)) OVER (ORDER BY DATE_FORMAT(c.content_release, '%Y-%m')), 0)) * 100, 2
    ) as monthly_growth_rate
FROM CONTENTS c
WHERE c.content_release IS NOT NULL
GROUP BY DATE_FORMAT(c.content_release, '%Y-%m'), c.content_type
ORDER BY release_month, monthly_revenue DESC;

-- Merch Performance by Type and Artist
SELECT 
    a.artist_id,
    CONCAT(a.artist_f_name, ' ', a.artist_l_name) as artist_name,
    m.merch_type,
    m.merch_status,
    SUM(ms.merch_sale_quantity) as total_units_sold,
    SUM(ms.merch_sale_quantity * ms.merch_sale_price) as total_revenue,
    m.merch_available_units as current_inventory,
    ROUND(SUM(ms.merch_sale_quantity) / NULLIF((SUM(ms.merch_sale_quantity) + m.merch_available_units), 0) * 100, 2) as sell_through_rate
FROM MERCH m
JOIN ARTISTS a ON m.artist_id = a.artist_id
LEFT JOIN MERCH_SALES ms ON m.merch_id = ms.merch_id
GROUP BY a.artist_id, artist_name, m.merch_type, m.merch_status, m.merch_available_units
ORDER BY total_revenue DESC;

-- Event Success Metrics
SELECT 
    e.event_name,
    e.event_type,
    e.event_date,
    e.event_location,
    e.event_status,
    COUNT(DISTINCT p.artist_id) as artist_count,
    COUNT(DISTINCT ea.fan_id) as attendance_count,
    COUNT(DISTINCT es.sale_id) as ticket_sales,
    SUM(es.event_sale_price) as ticket_revenue,
    ROUND(COUNT(DISTINCT ea.fan_id) / NULLIF(COUNT(DISTINCT es.sale_id), 0) * 100, 2) as attendance_rate
FROM EVENTS e
LEFT JOIN PARTICIPATIONS p ON e.event_id = p.event_id
LEFT JOIN EVENT_ATTENDANCE ea ON e.event_id = ea.event_id AND ea.attendance_status = 'confirmed'
LEFT JOIN EVENT_SALES es ON e.event_id = es.event_id
GROUP BY e.event_id, e.event_name, e.event_type, e.event_date, e.event_location, e.event_status
ORDER BY e.event_date DESC;

-- Artist Career Progression Analysis
SELECT 
    a.artist_id,
    CONCAT(a.artist_f_name, ' ', a.artist_l_name) as artist_name,
    a.artist_debut,
    DATEDIFF(CURDATE(), a.artist_debut) as days_since_debut,
    COUNT(DISTINCT e.training_id) as trainings_completed,
    COUNT(DISTINCT c.content_id) as content_produced,
    COUNT(DISTINCT p.event_id) as events_participated,
    COUNT(DISTINCT f.fan_id) as fan_count,
    SUM(c.stream_count) as career_streams,
    SUM(c.revenue_generated) as career_revenue
FROM ARTISTS a
LEFT JOIN ENROLLMENTS e ON a.artist_id = e.artist_id
LEFT JOIN CONTENTS c ON a.artist_id = c.artist_id
LEFT JOIN PARTICIPATIONS p ON a.artist_id = p.artist_id
LEFT JOIN FANS f ON a.artist_id = f.artist_id
GROUP BY a.artist_id, artist_name, a.artist_debut
ORDER BY career_revenue DESC;

-- Sales Performance by Type and Status
SELECT 
    s.sale_type,
    s.sale_status,
    COUNT(s.sale_id) as transaction_count,
    SUM(s.sale_quantity) as total_units,
    SUM(s.sale_total_amount) as total_revenue,
    AVG(s.sale_total_amount) as avg_transaction_value,
    ROUND(SUM(CASE WHEN s.sale_status = 'completed' THEN s.sale_total_amount ELSE 0 END) / NULLIF(SUM(s.sale_total_amount), 0) * 100, 2) as completion_rate
FROM SALES s
GROUP BY s.sale_type, s.sale_status
ORDER BY s.sale_type, total_revenue DESC;

-- Best Performing Content Types by Market
SELECT 
    m.market_region,
    c.content_type,
    COUNT(c.content_id) as content_count,
    AVG(c.stream_count) as avg_streams,
    AVG(c.revenue_generated) as avg_revenue,
    SUM(c.revenue_generated) as total_revenue,
    ROUND(AVG(c.revenue_generated) / NULLIF(AVG(c.production_cost), 0), 2) as roi_ratio
FROM CONTENTS c
JOIN MARKET_TARGETED_CONTENTS mtc ON c.content_id = mtc.content_id
JOIN MARKETS m ON mtc.market_id = m.market_id
GROUP BY m.market_region, c.content_type
HAVING content_count >= 1
ORDER BY m.market_region, roi_ratio DESC;

-- Training Program Completion and Subsequent Performance
SELECT 
    a.artist_id,
    CONCAT(a.artist_f_name, ' ', a.artist_l_name) as artist_name,
    t.training_name,
    e.enrollment_start_date,
    COUNT(DISTINCT c.content_id) as content_post_training,
    AVG(c.stream_count) as avg_streams_post_training,
    AVG(c.revenue_generated) as avg_revenue_post_training
FROM ARTISTS a
JOIN ENROLLMENTS e ON a.artist_id = e.artist_id
JOIN TRAININGS t ON e.training_id = t.training_id
LEFT JOIN CONTENTS c ON a.artist_id = c.artist_id AND c.content_release > e.enrollment_start_date
GROUP BY a.artist_id, artist_name, t.training_name, e.enrollment_start_date
ORDER BY avg_revenue_post_training DESC;

-- Fan Lifetime Value Analysis
SELECT 
    f.fan_id,
    f.fan_region,
    f.fan_country,
    f.fan_engagement_score,
    DATEDIFF(CURDATE(), f.fan_join_date) as days_as_fan,
    COUNT(s.sale_id) as total_purchases,
    SUM(s.sale_total_amount) as total_spent,
    AVG(s.sale_total_amount) as avg_purchase_value,
    CASE 
        WHEN COUNT(s.sale_id) >= 5 THEN 'VIP Customer'
        WHEN COUNT(s.sale_id) >= 2 THEN 'Regular Customer'
        ELSE 'One-time Customer'
    END as customer_segment
FROM FANS f
LEFT JOIN SALES s ON f.fan_id = s.fan_id AND s.sale_status = 'completed'
GROUP BY f.fan_id, f.fan_region, f.fan_country, f.fan_engagement_score, f.fan_join_date
ORDER BY total_spent DESC;

-- Event Type Effectiveness
SELECT 
    e.event_type,
    COUNT(DISTINCT e.event_id) as total_events,
    COUNT(DISTINCT p.artist_id) as total_artists,
    COUNT(DISTINCT ea.fan_id) as total_attendees,
    SUM(es.event_sale_price) as total_revenue,
    AVG(es.event_sale_price) as avg_ticket_price,
    ROUND(COUNT(DISTINCT ea.fan_id) / NULLIF(COUNT(DISTINCT e.event_id), 0), 0) as avg_attendance_per_event
FROM EVENTS e
LEFT JOIN PARTICIPATIONS p ON e.event_id = p.event_id
LEFT JOIN EVENT_ATTENDANCE ea ON e.event_id = ea.event_id AND ea.attendance_status = 'confirmed'
LEFT JOIN EVENT_SALES es ON e.event_id = es.event_id
WHERE e.event_status = 'completed'
GROUP BY e.event_type
ORDER BY total_revenue DESC;

-- Optimal Content Release Timing Analysis
SELECT 
    MONTH(c.content_release) as release_month,
    DAYNAME(c.content_release) as release_day,
    c.content_type,
    COUNT(c.content_id) as content_count,
    AVG(c.stream_count) as avg_streams,
    AVG(c.revenue_generated) as avg_revenue,
    ROUND(AVG(c.revenue_generated) / NULLIF(AVG(c.production_cost), 0), 2) as avg_roi
FROM CONTENTS c
WHERE c.content_release IS NOT NULL
GROUP BY MONTH(c.content_release), DAYNAME(c.content_release), c.content_type
ORDER BY avg_roi DESC;

-- Artist Cross-Promotion Opportunities
SELECT 
    a1.artist_id as artist1_id,
    CONCAT(a1.artist_f_name, ' ', a1.artist_l_name) as artist1_name,
    a2.artist_id as artist2_id,
    CONCAT(a2.artist_f_name, ' ', a2.artist_l_name) as artist2_name,
    COUNT(DISTINCT e1.event_id) as shared_events
FROM ARTISTS a1
JOIN PARTICIPATIONS p1 ON a1.artist_id = p1.artist_id
JOIN PARTICIPATIONS p2 ON p1.event_id = p2.event_id
JOIN ARTISTS a2 ON p2.artist_id = a2.artist_id AND a1.artist_id != a2.artist_id
JOIN EVENTS e1 ON p1.event_id = e1.event_id
GROUP BY a1.artist_id, artist1_name, a2.artist_id, artist2_name
HAVING shared_events >= 1
ORDER BY shared_events DESC;

-- Untapped Market Potential
SELECT 
    m.market_region,
    m.market_country,
    m.market_population,
    COUNT(DISTINCT mtc.content_id) as current_content,
    COUNT(DISTINCT f.fan_id) as current_fans,
    ROUND(COUNT(DISTINCT f.fan_id) / NULLIF(m.market_population, 0) * 1000000, 2) as fans_per_million,
    CASE 
        WHEN COUNT(DISTINCT mtc.content_id) = 0 THEN 'Untapped'
        WHEN COUNT(DISTINCT mtc.content_id) <= 3 THEN 'Underdeveloped'
        ELSE 'Developed'
    END as market_status
FROM MARKETS m
LEFT JOIN MARKET_TARGETED_CONTENTS mtc ON m.market_id = mtc.market_id
LEFT JOIN FANS f ON m.market_country = f.fan_country
GROUP BY m.market_region, m.market_country, m.market_population
ORDER BY market_population DESC;

-- Revenue Breakdown by Source
SELECT 
    'Content' as revenue_source,
    SUM(revenue_generated) as total_revenue,
    COUNT(content_id) as item_count,
    ROUND(SUM(revenue_generated) / NULLIF(COUNT(content_id), 0), 2) as avg_revenue_per_item
FROM CONTENTS
WHERE revenue_generated > 0

UNION ALL

SELECT 
    'Merchandise' as revenue_source,
    SUM(ms.merch_sale_quantity * ms.merch_sale_price) as total_revenue,
    COUNT(DISTINCT ms.merch_id) as item_count,
    ROUND(SUM(ms.merch_sale_quantity * ms.merch_sale_price) / NULLIF(COUNT(DISTINCT ms.merch_id), 0), 2) as avg_revenue_per_item
FROM MERCH_SALES ms

UNION ALL

SELECT 
    'Events' as revenue_source,
    SUM(es.event_sale_price) as total_revenue,
    COUNT(DISTINCT es.event_id) as item_count,
    ROUND(SUM(es.event_sale_price) / NULLIF(COUNT(DISTINCT es.event_id), 0), 2) as avg_revenue_per_item
FROM EVENT_SALES es

ORDER BY total_revenue DESC;

-- Cost vs Revenue Efficiency
SELECT 
    a.artist_id,
    CONCAT(a.artist_f_name, ' ', a.artist_l_name) as artist_name,
    SUM(c.production_cost) as total_production_cost,
    SUM(t.training_cost) as total_training_cost,
    SUM(c.production_cost + COALESCE(t.training_cost, 0)) as total_investment,
    SUM(c.revenue_generated) as total_revenue,
    (SUM(c.revenue_generated) - SUM(c.production_cost + COALESCE(t.training_cost, 0))) as net_profit,
    ROUND(SUM(c.revenue_generated) / NULLIF(SUM(c.production_cost + COALESCE(t.training_cost, 0)), 0), 2) as efficiency_ratio
FROM ARTISTS a
LEFT JOIN CONTENTS c ON a.artist_id = c.artist_id
LEFT JOIN ENROLLMENTS e ON a.artist_id = e.artist_id
LEFT JOIN TRAININGS t ON e.training_id = t.training_id
GROUP BY a.artist_id, artist_name
HAVING total_investment > 0
ORDER BY efficiency_ratio DESC;

-- Quarterly Performance Analysis
SELECT 
    CONCAT(YEAR(c.content_release), '-Q', QUARTER(c.content_release)) as quarter,
    c.content_type,
    COUNT(c.content_id) as content_count,
    SUM(c.stream_count) as total_streams,
    SUM(c.revenue_generated) as total_revenue,
    SUM(c.production_cost) as total_cost,
    (SUM(c.revenue_generated) - SUM(c.production_cost)) as net_profit,
    ROUND((SUM(c.revenue_generated) - SUM(c.production_cost)) / NULLIF(SUM(c.production_cost), 0) * 100, 2) as profit_margin
FROM CONTENTS c
WHERE c.content_release IS NOT NULL
GROUP BY YEAR(c.content_release), QUARTER(c.content_release), c.content_type
ORDER BY quarter, total_revenue DESC;

-- Executive Summary Dashboard
SELECT 
    (SELECT COUNT(*) FROM ARTISTS WHERE artist_status = 'active') as active_artists,
    (SELECT COUNT(*) FROM CONTENTS) as total_content,
    (SELECT COUNT(*) FROM FANS) as total_fans,
    (SELECT SUM(revenue_generated) FROM CONTENTS) as content_revenue,
    (SELECT SUM(ms.merch_sale_quantity * ms.merch_sale_price) FROM MERCH_SALES ms) as merch_revenue,
    (SELECT SUM(es.event_sale_price) FROM EVENT_SALES es) as event_revenue,
    (SELECT SUM(revenue_generated) FROM CONTENTS) + 
    (SELECT SUM(ms.merch_sale_quantity * ms.merch_sale_price) FROM MERCH_SALES ms) +
    (SELECT SUM(es.event_sale_price) FROM EVENT_SALES es) as total_revenue,
    (SELECT AVG(fan_engagement_score) FROM FANS) as avg_fan_engagement,
    (SELECT COUNT(*) FROM EVENTS WHERE event_status = 'completed') as completed_events,
    (SELECT COUNT(*) FROM MARKETS) as active_markets;